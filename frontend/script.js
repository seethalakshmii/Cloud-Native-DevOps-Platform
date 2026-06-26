async function load() {

    const health = await fetch("/health");
    const healthData = await health.json();
    document.getElementById("health").innerText = healthData.status;

    const home = await fetch("/");
    const homeData = await home.json();
    document.getElementById("msg").innerText = homeData.message;
}

load();


document.getElementById("form").addEventListener("submit", async (e) => {

    e.preventDefault();

    const data = {
        name: document.getElementById("name").value,
        email: document.getElementById("email").value,
        message: document.getElementById("message").value
    };

    const res = await fetch("/submit", {

        method: "POST",

        headers: {
            "Content-Type": "application/json"
        },

        body: JSON.stringify(data)

    });

    const result = await res.json();

    document.getElementById("response").innerText =
        result.message || result.error;
});


async function uploadFile() {

    const file = document.getElementById("fileInput").files[0];

    if (!file) {
        alert("Choose a file first");
        return;
    }

    const formData = new FormData();

    formData.append("file", file);

    const res = await fetch("/upload", {

        method: "POST",

        body: formData

    });

    const result = await res.json();

    document.getElementById("uploadStatus").innerText =
        result.message || result.error;
}