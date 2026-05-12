// data.js

const dataApp = {

    config: {
        apiUrl: "itemmaster.php",
        rowsPerPage: 10,
        tableId: "data-table",
        searchInput: "itemid"
    },

    mode: "add",

    callAPI(params, callback) {
        let url = this.config.apiUrl +
            "?query=" + params.query +
            "&rows=" + this.config.rowsPerPage +
            "&pages=" + (params.page || 1) +
            "&id=" + (params.id || "");

        fetch(url)
            .then(res => res.json())
            .then(callback)
            .catch(err => console.error(err));
    },

    loadPage(page) {
        currentRow = -1; // ✅ RESET HERE (VERY IMPORTANT)

        this.callAPI({ query: 2, page: page }, (res) => {
            currentPage = res.currentPage;
            totalPages = res.totalPages;
            fetchedData = res.data;

            renderTable(fetchedData);
        });
    },

    onRowClick(id) {
        this.setMode("edit");
        openTab(null, "Edit");

        this.callAPI({ query: 3, id: id }, (res) => {
            if (!res.success) return alert("No data");

            document.getElementById("tnitmid").value = res.data[0];
            document.getElementById("tcitmcd").value = res.data[1];
            document.getElementById("tcitmnm").value = res.data[2];
        });
    },

    search() {
        const val = document.getElementById(this.config.searchInput).value.trim();
        if (!val) return alert("Enter value");

        this.callAPI({ query: 1, id: val }, (res) => {
            if (!res.success) return alert("Not found");

            const rowIndex = res.rowIndex;
            const page = Math.floor(rowIndex / this.config.rowsPerPage) + 1;

            this.loadPage(page);

            setTimeout(() => {
                const rows = document.querySelectorAll(`#${this.config.tableId} tbody tr`);
                const target = rows[rowIndex % this.config.rowsPerPage];
                if (target) target.classList.add("highlight");
            }, 500);
        });
    },

    fnsave() {
        const id = document.getElementById("tnitmid").value;
        const code = document.getElementById("tcitmcd").value;
        const name = document.getElementById("tcitmnm").value;

        if (!code || !name) return alert("Fill all fields");

        let formData = new FormData();
        formData.append("query", 4);
        formData.append("code", code);
        formData.append("name", name);

        if (this.mode === "edit" && id) {
            formData.append("id", id);
        }

        fetch(this.config.apiUrl, {
            method: "POST",
            body: formData
        })
        .then(res => res.json())
        .then(res => {

            if (res.status === "inserted") {
                alert("Inserted");
                this.clearForm();
                this.setMode("add");
            }

            if (res.status === "updated") {
                alert("Updated");
            }

            this.loadPage(1);
            openTab(null, "List");
        });
    },

    setMode(mode) {
        this.mode = mode;

        const btn = document.getElementById("editTabBtn");

        if (mode === "edit") {
            btn.textContent = "Edit";
            btn.disabled = true;
        } else {
            btn.textContent = "Append";
            btn.disabled = false;
        }
    },

    clearForm() {
        document.getElementById("tnitmid").value = "";
        document.getElementById("tcitmcd").value = "";
        document.getElementById("tcitmnm").value = "";
    }
};