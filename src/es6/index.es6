let contentMap = {};

for(let elem of document.body.children) {
    let tagName = elem.tagName.toLowerCase();
    switch(tagName) {
        case 'SCRIPT':
            // don't add script tags
            break;
        case 'HEADER':
        case 'FOOTER':
            contentMap[tagName] = elem;
            break;
        default:
            contentMap[elem.id] = elem;
            break;
    }
}

// current content focus (initializes to header)
// this should not be directly modified
// instead, use changeFocus() so we can have special behavior
let focus = contentMap.header;

function changeFocus(elem) {}

document.addEventListener('scroll', (event) => {
    event.stopPropagation();

    // TODO: scrollIntoView() stuff
    // console.log(event);
});
