var SwissBioPics;
SwissBioPics = (() => {
    "use strict";
    var e = {
            856: (e, t, s) => {
                s.r(t);
                const l = document.createElement("template");
                l.innerHTML =
                    '<style>span.subcell_description {\n    padding-left: 0.5em;\n}\n\nul.subcell_present,\nul.notpresent {\n    list-style-type: none;\n    list-style: none;\n    padding: 0px;\n}\n\nul.subcell_present li::before {\n    content: "âœ“"\n}\n\nul.notpresent li::before {\n    content: "âœ—";\n}\n\n#swissbiopic {\n    display: grid;\n    grid-template-areas: "picture terms";\n    grid-template-columns: 1fr 1fr;\n    grid-column-gap: 10px;\n}\n\n.svg {\n    grid-area: picture;\n}\n\n.terms {\n    grid-area: terms;\n}\n</style><div id="swissbiopic"><div class="terms"></div></div>';
                class n extends HTMLElement {
                    static anyNonOkIsAnError() {
                        if (!response.ok) throw Error(response.statusText);
                        return response;
                    }
                    constructor() {
                        super(),
                            (this.shadow = this.attachShadow({ mode: "open" })),
                            this.shadow.appendChild(l.content.cloneNode(!0)),
                            (this.wrapper = this.shadow.querySelector("#swissbiopic")),
                            (this.develop = null !== this.getAttribute("developer") && void 0 !== this.getAttribute("developer")),
                            this.develop && console.log("in development mode"),
                            (this.sls = this.getAttribute("sls")),
                            (this.gos = this.getAttribute("gos")),
                            (this.taxid = this.getAttribute("taxid"));
                    }
                    render() {
                        let e = fetch(
                            ((e, t, s, l) => {
                                let n = "https://www.swissbiopics.org/";
                                !0 === this.develop && ((n = "http://localhost:8081/"), console.log("developer", n));
                                let i = `${n}/api/${t}/sl/${e}`;
                                return null != s && (i = `${n}/api/${t}/go/${s}`), i;
                            })(this.sls, this.taxid, this.gos)
                        )
                            .then(this.anyNonOkIsAnError)
                            .then((e) => e.text())
                            .then((e) => this.wrapper.insertAdjacentHTML("beforeend", e));
                        this.liItemTemplate &&
                            (e = e


                                ),
                            e
                                .then(() => this.addEventHandlers(this.wrapper, this.terms))
                                .then(() => this.shadow.appendChild(this.wrapper))
                                .then(() => this.shadow.dispatchEvent(new CustomEvent("svgloaded")))
                                .catch((e) => {
                                    this.showErrorMessageToUser(e, this.shadow), this.shadow.dispatchEvent(new CustomEvent("failedtoload"));
                                });
                    }
                    connectedCallback() {
                        const e = "sibSwissBioPicsSlLiItem",
                            t = document.getElementById(e);
                        if (null !== t) (this.liItemTemplate = t.content), (this.terms = this.shadow.querySelector(".terms")), this.setAttribute("contentid", e);
                        else {
                            if (null === this.getAttribute("contentid")) throw "Neither #sibSwissBioPicsSlLiItem template nor #sibSwissBioPicsSlUlOverride content set";
                            {
                                const e = document.getElementById(this.getAttribute("contentid"));
                                if (null === e) throw "Neither #sibSwissBioPicsSlLiItem template nor #sibSwissBioPicsSlUlOverride content set";
                                e.parentElement.removeChild(e), this.wrapper.appendChild(e), (e.hidden = !1), (this.terms = e);
                            }
                        }
                        const s = document.getElementById("sibSwissBioPicsStyle");
                        if (null !== this.getAttribute("styleid")) {
                            let e = document.getElementById(this.getAttribute("styleid")).content.cloneNode(!0);
                            this.shadow.append(e);
                        } else if (null !== s) {
                            let e = s.content.cloneNode(!0);
                            this.shadow.append(e);
                            const t = document.createElement("style");
                            (t.innerText =
                                ".subcell_present li,\n.subcell_present path,\n.subcell_present circle,\n.subcell_present ellipse,\n.subcell_present polygon,\n.subcell_present rect,\n.subcell_present polyline,\n.subcell_present line {\n    fill: lightyellow;\n    fill-opacity: .50;\n    background-color: lightyellow;\n}\n\n.subcell_present ul.lookedAt,\n.subcell_present path.lookedAt,\n.subcell_present circle.lookedAt,\n.subcell_present ellipse.lookedAt,\n.subcell_present polygon.lookedAt,\n.subcell_present rect.lookedAt,\n.subcell_present polyline.lookedAt,\n.subcell_present line.lookedAt {\n    stroke: blue;\n    fill-opacity: .75;\n}\n\n.lookedAt {\n    stroke: orange;\n    fill: red;\n    fill-opacity: .25;\n    background-color: orange;\n}\n\n/*Cytoskeleton is special cased to not do a fill*/\n\n#SL0090 .lookedAt {\n    fill: none;\n}\n"),
                                this.shadow.append(t);
                        }
                        this.render();
                    }
                    showErrorMessageToUser(e, t) {
                        console.log(e), (t.innerHTML = '<span class="failure">Failed to fetch a SwissBioPic, please try again later.</span>');
                    }
                    findAndSort(e, t) {
                        const s = new Set();
                        return Array.from(e.querySelectorAll(t))
                            .sort((e, t) => e.querySelector(":scope > .subcell_name").textContent.localeCompare(t.querySelector(":scope > .subcell_name").textContent))
                            .filter((e) => {
                                let t = e.querySelector(":scope > .subcell_name").parentElement.id;
                                return !s.has(t) && (s.add(t), !0);
                            });
                    }




                    addEventHandlers(e, t) {
                        const s = "path, circle, ellipse, polygon, rect, polyline, line";
                        for (let l of e.querySelectorAll(":scope svg .subcellular_location")) {
                            for (let e of l.querySelectorAll(":scope " + s)) e.addEventListener("mouseenter", (e) => this.highLight(e, l, s)), e.addEventListener("mouseleave", (e) => this.removeHiglight(e, l, s));
                            if (l.id) {
                                let e = t.querySelector(`:scope #${l.id}term`);
                                null !== e &&
                                    (e.addEventListener("mouseenter", (e) => this.highLight(e, l, s)),
                                    e.addEventListener("mouseleave", (e) => this.removeHiglight(e, l, s)),
                                    e.addEventListener("touchstart", (e) => this.highLight(e, l, s), { passive: !0 }),
                                    e.addEventListener("touchend", (e) => this.removeHiglight(e, l, s), { passive: !0 }));
                            }
                        }
                    }


                }
                window.customElements.get("sib-swissbiopics-sl") || window.customElements.define("sib-swissbiopics-sl", n);
            },
        },
        t = {};
    function s(l) {
        if (t[l]) return t[l].exports;
        var n = (t[l] = { exports: {} });
        return e[l](n, n.exports, s), n.exports;
    }
    return (
        (s.r = (e) => {
            "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, { value: "Module" }), Object.defineProperty(e, "__esModule", { value: !0 });
        }),
        s(856)
    );
})();
