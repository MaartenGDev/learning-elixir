import socket from "./socket";
const currentPartyCode = localStorage.getItem('CURRENT_PARTY_CODE');

if(currentPartyCode){
    let channel = socket.channel(`learning-party:${currentPartyCode}`, {})

    const afterInit = () => {
        document.querySelectorAll('[data-trigger-sync]').forEach(trigger => {
            const data = JSON.parse(trigger.dataset.triggerSync);

            channel.push(`learning-party:${currentPartyCode}`, data)
        })
    }

    channel.join()
        .receive("ok", afterInit)
        .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on(`learning-party:${currentPartyCode}`, videoChange => {
        const currentPath = window.location.pathname;
        const nextPath = `/courses/${videoChange.course_id}/modules/${videoChange.module_id}/videos/${videoChange.video_id}`;

        if(currentPath !== nextPath){
            window.location = nextPath;
        }
    })
}