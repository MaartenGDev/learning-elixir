


const accordions = document.querySelectorAll('.accordion__group');

accordions.forEach(accordion => {
    const toggleElem = accordion.querySelector('.accordion__title')

    toggleElem.addEventListener('click',() => {
        accordion.classList.toggle('accordion__group--active')
    })
})