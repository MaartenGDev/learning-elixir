import socket from "./socket";

const authenticatedUserId = localStorage.getItem('USER_ID');
const currentPartyCode = localStorage.getItem('CURRENT_PARTY_CODE');

if (currentPartyCode) {
    let channel = socket.channel(`learning-party:${currentPartyCode}`, {})

    const afterInit = () => {
        window.triggerSync = (data) => {
            channel.push(`learning-party:${currentPartyCode}`, {source: authenticatedUserId, ...data});
        }

        document.querySelectorAll('[data-trigger-sync]').forEach(trigger => {
            const data = JSON.parse(trigger.dataset.triggerSync);
            window.triggerSync(data);
        })
    }

    channel.join()
        .receive("ok", afterInit)
        .receive("error", resp => {
            console.log("Unable to join", resp)
        })

    channel.on(`learning-party:${currentPartyCode}`, event => {
        if (event.source === authenticatedUserId) {
            return;
        }

        switch (event.type) {
            case "VIDEO_CHANGED":
                const currentPath = window.location.pathname;
                const nextPath = `/courses/${event.course_id}/modules/${event.module_id}/videos/${event.video_id}`;

                if (currentPath !== nextPath) {
                    window.location = nextPath;
                }
                break;
            case "PLAYBACK_STATUS":
                const shouldPause = event.paused;

                document.querySelectorAll('video').forEach(video => {
                    shouldPause
                        ? video.pause()
                        : video.play();
                })
                break;
            case "VIDEO_CHANGED_TIME_STAMP":
                document.querySelectorAll('video').forEach(video => {
                    video.currentTime = event.currentTime;
                })
                break;
            default:
                console.log('unknown event: ', event)
                break;
        }
    })
}

document.querySelectorAll('video').forEach(video => {
    video.addEventListener('play', () => window.triggerSync({
        "source": authenticatedUserId,
        "type": "PLAYBACK_STATUS",
        "paused": false
    }));

    video.addEventListener('pause', () => window.triggerSync({
        "source": authenticatedUserId,
        "type": "PLAYBACK_STATUS",
        "paused": true
    }))

    let lastTimeUpdate = -1;

    video.addEventListener('timeupdate', e => {
        const currentTime = e.currentTarget.currentTime;
        const timeDifference = Math.abs(currentTime - lastTimeUpdate);

        if (timeDifference < 2) {
            lastTimeUpdate = currentTime;
            return;
        }

        window.triggerSync({
            "source": authenticatedUserId,
            "type": "VIDEO_CHANGED_TIME_STAMP",
            "currentTime": e.currentTarget.currentTime
        })

        lastTimeUpdate = currentTime;
    })
});