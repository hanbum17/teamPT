// vroomEvent.js

function initializeEvents(data) {
    // Initialize events with the fetched data
    console.log('Initializing events with data:', data);

    let leftEvents = data.slice(0, 5);
    let rightEvents = data.slice(5, 10);

    function renderEvents() {
        const leftContainer = document.getElementById('left');
        const rightContainer = document.getElementById('right');

        leftContainer.innerHTML = '';
        rightContainer.innerHTML = '';

        leftEvents.forEach(event => {
            leftContainer.innerHTML += `
                <div class="box" data-id="${event.id}">
                    <img src="${event.img}" alt="${event.title}">
                    <div class="text-container">
                        <h3>${event.title}</h3>
                        <div>위치: ${event.address}</div>
                        <div>기간: ${event.period}</div>
                    </div>
                </div>
            `;
        });

        rightEvents.forEach(event => {
            rightContainer.innerHTML += `
                <div class="box" data-id="${event.id}">
                    <img src="${event.img}" alt="${event.title}">
                    <div class="text-container">
                        <h3>${event.title}</h3>
                        <div>위치: ${event.address}</div>
                        <div>기간: ${event.period}</div>
                    </div>
                </div>
            `;
        });
    }

    function showDetails(eventId) {
        const event = data.find(e => e.id === eventId);
        if (!event) return;

        const leftDetail = document.getElementById('left-detail');
        const rightDetail = document.getElementById('right-detail');

        leftDetail.innerHTML = `
            <img src="${event.img}" alt="${event.title}">
            <h2>${event.title}</h2>
            <p>위치: ${event.address}</p>
            <p>기간: ${event.period}</p>
            <p>Rating: ${event.rating}</p>
            <p>Comments: <span>0</span></p>
            <button>Favorite</button>
            <p>Description: ${event.description}</p>
            <p>Location: N/A</p>
            <p>Operating Hours: N/A</p>
            <p>Phone: N/A</p>
            <p>Parking: N/A</p>
        `;

        rightDetail.innerHTML = `
            <p>Overall Rating: ${event.rating}</p>
            <p>Total Reviews: 0</p>
        `;

        document.getElementById('left').style.display = 'none';
        document.getElementById('right').style.display = 'none';
        document.getElementById('detail-view').style.display = 'flex';
    }

    function showEvents() {
        document.getElementById('left').style.display = 'flex';
        document.getElementById('right').style.display = 'flex';
        document.getElementById('detail-view').style.display = 'none';
    }

    function handleClick(e) {
        const box = e.target.closest('.box');
        if (box) {
            const eventId = parseInt(box.dataset.id, 10);
            showDetails(eventId);
        }
    }

    function handleBackButtonClick() {
        showEvents();
    }

    document.getElementById('left').addEventListener('click', handleClick);
    document.getElementById('right').addEventListener('click', handleClick);
    document.getElementById('back-button').addEventListener('click', handleBackButtonClick);

    renderEvents();
}
