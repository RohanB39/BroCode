document.addEventListener('DOMContentLoaded', () => {
    const themeToggle = document.getElementById('theme-toggle');
    const body = document.body;
    const navbar = document.querySelector('.navbar');
    const brand = document.querySelector('.brand');
    const navbarLinks = document.querySelectorAll('.navbar-links a');
    const navbarLinks2 = document.querySelectorAll('.middleNav2 a');
    const themeIcon = themeToggle ? themeToggle.querySelector('i') : null;
    const loginBtn = document.querySelector('.navbar-auth .login');
    const signupBtn = document.querySelector('.navbar-auth .signup');
    const loginForm = document.querySelector('.login-form');
    const nav2 = document.querySelector('.nav2');
    const darkBlack = document.querySelector('.darkBlack');
    const footerIcons = document.querySelectorAll('.icons a');

    const searchIcon = document.getElementById('search-icon');
    const searchBox = document.getElementById('search-box');

    const textElement = document.getElementById('typewriter');
    const textArray = ['Java', 'JavaScript'];
    let arrayIndex = 0;
    let charIndex = 0;
    const typingSpeed = 100;
    const deletingSpeed = 50;
    const delayBetweenWords = 1000;

    // Function to apply the dark mode
    const applyDarkMode = () => {
        body.classList.add('dark-mode');
        navbar.classList.add('dark-mode');
        brand.classList.add('dark-mode');
        if (themeIcon) themeIcon.classList.add('dark-mode');
        navbarLinks.forEach(link => link.classList.add('dark-mode'));
        navbarLinks2.forEach(link => link.classList.add('dark-mode'));
        footerIcons.forEach(link => link.classList.add('dark-mode'));
        if (loginBtn) loginBtn.classList.add('dark-mode');
        if (signupBtn) signupBtn.classList.add('dark-mode');
        if (loginForm) loginForm.classList.add('dark-mode');
        if (nav2) nav2.classList.add('dark-mode');
        if (themeIcon) themeIcon.classList.replace('fa-moon', 'fa-sun');
        if (darkBlack) darkBlack.classList.add('dark-mode');
    };

    // Function to remove the dark mode
    const removeDarkMode = () => {
        body.classList.remove('dark-mode');
        navbar.classList.remove('dark-mode');
        brand.classList.remove('dark-mode');
        if (themeIcon) themeIcon.classList.remove('dark-mode');
        navbarLinks.forEach(link => link.classList.remove('dark-mode'));
        navbarLinks2.forEach(link => link.classList.remove('dark-mode'));
        footerIcons.forEach(link => link.classList.remove('dark-mode'));
        if (loginBtn) loginBtn.classList.remove('dark-mode');
        if (signupBtn) signupBtn.classList.remove('dark-mode');
        if (loginForm) loginForm.classList.remove('dark-mode');
        if (nav2) nav2.classList.remove('dark-mode');
        if (themeIcon) themeIcon.classList.replace('fa-sun', 'fa-moon');
        if (darkBlack) darkBlack.classList.remove('dark-mode');
    };

    // Load theme from localStorage
    if (localStorage.getItem('theme') === 'dark') {
        applyDarkMode();
    } else {
        removeDarkMode();
    }

    if (themeToggle) {
        themeToggle.addEventListener('click', () => {
            if (body.classList.contains('dark-mode')) {
                removeDarkMode();
                localStorage.setItem('theme', 'light');
            } else {
                applyDarkMode();
                localStorage.setItem('theme', 'dark');
            }
        });
    }

    if (searchIcon) {
        searchIcon.addEventListener('click', () => {
            if (searchBox) {
                if (searchBox.style.display === 'none' || searchBox.style.display === '') {
                    searchBox.style.display = 'inline-block';
                } else {
                    searchBox.style.display = 'none';
                }
            }
        });
    }

    // function for sliding text 
    function type() {
        if (charIndex < textArray[arrayIndex].length) {
            textElement.innerHTML += textArray[arrayIndex].charAt(charIndex);
            charIndex++;
            setTimeout(type, typingSpeed);
        } else {
            setTimeout(deleteText, delayBetweenWords);
        }
    }

    function deleteText() {
        if (charIndex > 0) {
            textElement.innerHTML = textElement.innerHTML.substring(0, charIndex - 1);
            charIndex--;
            setTimeout(deleteText, deletingSpeed);
        } else {
            arrayIndex = (arrayIndex + 1) % textArray.length;
            setTimeout(type, typingSpeed);
        }
    }

    type();
});



let currentIndex = 0;

document.getElementById('next').addEventListener('click', () => {
    const videoContainer = document.querySelector('.videoContainer');
    const videoBoxes = document.querySelectorAll('.videoBox');
    const totalVideos = videoBoxes.length;
    const boxesPerView = 3;
    const widthPerBox = videoBoxes[0].offsetWidth + 20;

    if (currentIndex < totalVideos - boxesPerView) {
        currentIndex++;
    } else {
        currentIndex = 0;
    }

    videoContainer.style.transform = `translateX(-${currentIndex * widthPerBox}px)`;
});

document.getElementById('prev').addEventListener('click', () => {
    const videoContainer = document.querySelector('.videoContainer');
    const videoBoxes = document.querySelectorAll('.videoBox');
    const totalVideos = videoBoxes.length;
    const boxesPerView = 3;
    const widthPerBox = videoBoxes[0].offsetWidth + 20; 
    if (currentIndex > 0) {
        currentIndex--;
    } else {
        currentIndex = totalVideos - boxesPerView;
    }

    videoContainer.style.transform = `translateX(-${currentIndex * widthPerBox}px)`;
});
