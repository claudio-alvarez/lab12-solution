export const cmpFnStartDate = ({dataset : { startDate : a }}, {dataset : { startDate : b }}) => a.localeCompare(b);
export const cmpFnEventName = ({dataset : { eventName : a }}, {dataset : { eventName : b }}) => a.localeCompare(b);

export const registerClickHandlerForSortButton = (btn, dataAtt, compareFn) => {
    btn.addEventListener('click', ev => {
        Array.from(document.querySelectorAll(`div.event-list > div[data-${dataAtt}]`))
            .sort(compareFn)
            .forEach((item) => item.parentNode.appendChild(item));
    });
}

export const initSortButtons = () => {
    let event_lst = document.querySelector('div.event-list');
    if (event_lst) {
        document.querySelectorAll(".btn-sort-date").forEach((element) => {
            registerClickHandlerForSortButton(
                element, 'start-date', cmpFnStartDate);
        });
        document.querySelectorAll(".btn-sort-name").forEach((element) => {
            registerClickHandlerForSortButton(
                element, 'event-name', cmpFnEventName);
        });
    }
}

(() => {
    // Click handlers are registered for the event sort buttons
    document.addEventListener("turbolinks:load", (ev) => {
        initSortButtons();
    });
})();
