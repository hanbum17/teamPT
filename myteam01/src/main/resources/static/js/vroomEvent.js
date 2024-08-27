document.addEventListener('DOMContentLoaded', () => {
    const events = [
        { id: 1, title: 'Event 1', location: 'Location 1', date: '2024-08-26', rating: 4.5, description: 'Description 1', img: 'https://via.placeholder.com/150' },
        { id: 2, title: 'Event 2', location: 'Location 2', date: '2024-08-27', rating: 4.0, description: 'Description 2', img: 'https://via.placeholder.com/150' },
        { id: 3, title: 'Event 3', location: 'Location 3', date: '2024-08-28', rating: 3.5, description: 'Description 3', img: 'https://via.placeholder.com/150' },
        { id: 4, title: 'Event 4', location: 'Location 4', date: '2024-08-29', rating: 4.2, description: 'Description 4', img: 'https://via.placeholder.com/150' },
        { id: 5, title: 'Event 5', location: 'Location 5', date: '2024-08-30', rating: 4.7, description: 'Description 5', img: 'https://via.placeholder.com/150' },
        { id: 6, title: 'Event 6', location: 'Location 6', date: '2024-08-31', rating: 4.1, description: 'Description 6', img: 'https://via.placeholder.com/150' },
        { id: 7, title: 'Event 7', location: 'Location 7', date: '2024-09-01', rating: 4.3, description: 'Description 7', img: 'https://via.placeholder.com/150' },
        { id: 8, title: 'Event 8', location: 'Location 8', date: '2024-09-02', rating: 4.0, description: 'Description 8', img: 'https://via.placeholder.com/150' },
        { id: 9, title: 'Event 9', location: 'Location 9', date: '2024-09-03', rating: 3.9, description: 'Description 9', img: 'https://via.placeholder.com/150' },
        { id: 10, title: 'Event 10', location: 'Location 10', date: '2024-09-04', rating: 4.6, description: 'Description 10', img: 'https://via.placeholder.com/150' }
    ];

    let leftEvents = events.slice(0, 5);
    let rightEvents = events.slice(5, 10);

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
                        <div>위치: ${event.location}</div>
                        <div>기간: ${event.date}</div>
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
                        <div>위치: ${event.location}</div>
                        <div>기간: ${event.date}</div>
                    </div>
                </div>
            `;
        });
    }

    function showDetails(eventId) {
        const event = events.find(e => e.id === eventId);
        if (!event) return;

        const leftDetail = document.getElementById('left-detail');
        const rightDetail = document.getElementById('right-detail');

        leftDetail.innerHTML = `
            <img src="${event.img}" alt="${event.title}">
            <h2>${event.title}</h2>
            <p>위치: ${event.location}</p>
            <p>기간: ${event.date}</p>
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

        // Hide the existing events
        document.getElementById('left').style.display = 'none';
        document.getElementById('right').style.display = 'none';

        // Show the detail view
        document.getElementById('detail-view').style.display = 'flex';
    }

    function showEvents() {
        // Show the existing events
        document.getElementById('left').style.display = 'flex';
        document.getElementById('right').style.display = 'flex';

        // Hide the detail view
        document.getElementById('detail-view').style.display = 'none';
    }

    function handleClick(e) {
        const box = e.target.closest('.box');
        if (box) {
            const eventId = parseInt(box.dataset.id, 10);
            console.log(`Clicked event ID: ${eventId}`); // Debugging
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
});
