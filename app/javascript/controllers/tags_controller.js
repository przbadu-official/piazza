import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="tags"
export default class extends Controller {
    static targets = ['template', 'container', 'input']

    addTag() {
        let templateHtml = this.templateTarget.innerHTML

        templateHtml = templateHtml.replace(
            /{value}/g,
            this.inputTarget.value
        )

        this.containerTarget.insertAdjacentHTML(
            'beforeend', templateHtml
        )
    }
}
