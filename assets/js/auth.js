const userId = localStorage.getItem('USER_ID');

if(!userId){
    const userId =  Math.random().toString(36).substr(2, 20);
    localStorage.setItem('USER_ID', userId)
}