let contentList = Array.from(document.body.children).filter(e => e.tagName.toLowerCase() !== 'SCRIPT');

// index of current content focus (initializes to header)
let focusIndex = 0;

document.addEventListener('scroll', event => {
    event.stopPropagation();

    // TODO
    // contentList[focusIndex].scrollIntoView({behavior: 'smooth', block: 'start'});
    // console.log(event);
});
