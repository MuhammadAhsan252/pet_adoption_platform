import { Controller } from "@hotwired/stimulus";
import EditorJS from "@editorjs/editorjs";

// These are the plugins
import CodeTool from "@editorjs/code";
import Header from "@editorjs/header";
import ImageTool from "@editorjs/image";
import List from "@editorjs/list";
import Paragraph from "@editorjs/paragraph";
 
// Connects to data-controller="editor"
export default class extends Controller {
  static targets = ["blog_content"];

  csrfToken() {
    const metaTag = document.querySelector("meta[name='csrf-token']");
    console.log(metaTag);
    return metaTag ? metaTag.content : "";
  }
  connect() {

    const initialContent = this.getInitialContent();

    this.contentEditor = new EditorJS({
      // Holder is the target element
      holder: this.blog_contentTarget,
      data: initialContent,
      tools: {
        header: {
          class: Header,
        },
        list: {
          class: List,
        },
        paragraph: {
          class: Paragraph,
          config: {
            inlineToolbar: true,
          },
        },
        code: CodeTool,
        image: {
          class: ImageTool,
          config: {
            endpoints: {
              byFile: `/blogs/upload_image`,
            },
            additionalRequestHeaders: {
              "X-CSRF-Token": this.csrfToken(),
            },
          },
        },
      },
    });

    this.element.addEventListener("submit", this.saveEditorData.bind(this));
  }

  getInitialContent() {
    const hiddenContentField = document.getElementById(
      "blog_content_hidden"
    );
    if (hiddenContentField && hiddenContentField.value) {
      return JSON.parse(hiddenContentField.value);
    }
    return {};
  }

  async saveEditorData(event) {
    event.preventDefault();

    const outputData = await this.contentEditor.save();
    const blogForm = this.element;

    const hiddenInput = document.getElementById("blog_content_hidden");

    hiddenInput.value = JSON.stringify(outputData);
    blogForm.submit();
  }
}
