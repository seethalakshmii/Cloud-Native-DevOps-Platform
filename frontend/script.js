const API_URL = "/api";

async function loadData() {

    try {

        const msg = await fetch(`${API_URL}/`);
        const msgData = await msg.json();

        document.getElementById("message").innerText =
            msgData.message;

        const health = await fetch(`${API_URL}/health`);
        const healthData = await health.json();

        document.getElementById("health").innerText =
            healthData.status;

    } catch (error) {

        document.getElementById("message").innerText =
            "Backend unavailable";
    }
}

loadData();