const container = document.querySelector('.flip-container');

container.addEventListener('mouseover', () => {
    container.classList.add('hover');
});

container.addEventListener('mouseout', () => {
    container.classList.remove('hover');
});
