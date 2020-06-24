(() => {
    document.addEventListener("turbolinks:load", () => {
        const links = document.querySelectorAll("a[data-method=delete]");
        links.forEach((element) => {
            element.addEventListener("ajax:success", () => {
                let notice = document.querySelector("#notice");
                let newnotice = document.createElement("div")
                newnotice.setAttribute("id", "notice")
                newnotice.innerHTML = `
                <div class="row ml-0 mt-3" role="alert">
                    <div id="notice" class="alert alert-success">Event deleted successfully.</div>
                </div>
                `;

                if (notice) {
                    let parent = notice.parentNode;
                    parent.replaceChild(newnotice, notice);
                }
                else {
                    let main_content = document.querySelector("#main_content");
                    main_content.insertBefore(newnotice, main_content.firstChild);
                }

                element.closest("tr").remove();
                window.setTimeout( () => newnotice.remove(), 3000);
            })
        })
    })
})()