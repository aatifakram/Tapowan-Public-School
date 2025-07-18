<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Tapowan Public School - Login / Dashboard</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

    <!-- Chart.js for reports -->

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        /* Custom styles for the login page */

        :root {

            --primary: #3B30A3; /* Deeper Indigo */

            --primary-dark: #2C247A; /* Even Deeper Indigo */

            --secondary: #0D9488; /* Teal 600 */

            --accent: #D97706; /* Amber 700 */

            --dark: #1F2937; /* Gray 800 */

            --light: #F9FAFB; /* Gray 50 */

            --gray-light: #E5E7EB; /* Gray 200 */

            --gray-medium: #6B7280; /* Gray 500 */

            --gray-dark: #374151; /* Gray 700 */

            --border-color: #D1D5DB; /* Gray 300 for borders */

            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);

            --modal-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);

        }



        body {

            font-family: 'Inter', sans-serif;

            background-color: var(--light);

            color: var(--dark);

            display: flex;

            justify-content: center;

            align-items: center;

            min-height: 100vh;

            margin: 0;

            overflow: hidden; /* Prevent body scroll when modals are open */

        }



        /* Login UI Specific Styles */

        #login-ui {

            display: flex; /* Initially flex to center content */

            justify-content: center;

            align-items: center;

            min-height: 100vh;

            width: 100%;

        }



        .login-container {

            background-color: #ffffff;

            border-radius: 1.25rem; /* Slightly more rounded */

            box-shadow: var(--modal-shadow); /* More pronounced shadow */

            padding: 3rem; /* Increased padding */

            width: 100%;

            max-width: 480px; /* Slightly wider */

            text-align: center;

            animation: fadeIn 0.6s ease-out;

        }



        .login-header {

            display: flex;

            flex-direction: column;

            align-items: center;

            margin-bottom: 2.5rem; /* Increased margin */

        }



        .login-header img {

            width: 90px; /* Slightly larger */

            height: 90px;

            margin-bottom: 1.25rem;

            animation: popIn 0.5s ease-out;

        }



        .login-header h1 {

            font-size: 2.5rem; /* Larger font size */

            font-weight: 700;

            color: var(--primary-dark);

            animation: slideInFromTop 0.5s ease-out;

        }



        .role-selection {

            display: flex;

            justify-content: space-around;

            margin-bottom: 2rem; /* Increased margin */

            gap: 1.25rem; /* Increased gap */

        }



        .role-button {

            flex: 1;

            padding: 1rem 1.25rem; /* Increased padding */

            border-radius: 0.75rem; /* More rounded */

            border: 1px solid var(--border-color);

            background-color: var(--light);

            color: var(--gray-dark);

            font-weight: 500;

            cursor: pointer;

            transition: all 0.2s ease;

            display: flex;

            flex-direction: column;

            align-items: center;

            gap: 0.75rem; /* Increased gap */

        }



        .role-button i {

            font-size: 1.75rem; /* Larger icons */

            color: var(--gray-medium);

        }



        .role-button.active {

            border-color: var(--primary);

            background-color: var(--primary);

            color: white;

            box-shadow: 0 6px 15px rgba(59, 48, 163, 0.25); /* Stronger, primary-colored shadow */

        }



        .role-button.active i {

            color: white;

        }



        .role-button:hover:not(.active) {

            background-color: #F3F4F6; /* Lighter gray on hover */

            color: var(--primary-dark);

            border-color: var(--primary);

        }



        .role-button:hover:not(.active) i {

            color: var(--primary);

        }



        .form-group {

            margin-bottom: 1.5rem; /* Increased margin */

            text-align: left;

        }



        .form-group label {

            display: block;

            font-size: 0.95rem; /* Slightly larger font */

            font-weight: 500;

            color: var(--gray-dark);

            margin-bottom: 0.6rem; /* Increased margin */

        }



        .form-group input, .form-group select, .form-group textarea {

            width: 100%;

            padding: 0.85rem 1.1rem; /* Increased padding */

            border: 1px solid var(--border-color);

            border-radius: 0.6rem; /* More rounded */

            font-size: 1.05rem; /* Slightly larger font */

            color: var(--dark);

            background-color: #ffffff; /* White background for inputs */

            transition: all 0.2s ease;

        }



        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {

            outline: none;

            border-color: var(--primary);

            box-shadow: 0 0 0 4px rgba(59, 48, 163, 0.15); /* Softer, primary-colored focus ring */

        }



        .login-button {

            width: 100%;

            padding: 1rem 1.75rem; /* Increased padding */

            background-color: var(--primary);

            color: white;

            font-size: 1.15rem; /* Slightly larger font */

            font-weight: 600;

            border: none;

            border-radius: 0.75rem; /* More rounded */

            cursor: pointer;

            transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;

            box-shadow: 0 4px 10px rgba(59, 48, 163, 0.2);

        }



        .login-button:hover {

            background-color: var(--primary-dark);

            transform: translateY(-2px);

            box-shadow: 0 6px 15px rgba(59, 48, 163, 0.3);

        }



        .login-button:active {

            transform: translateY(0);

            box-shadow: 0 2px 5px rgba(59, 48, 163, 0.2);

        }



        .forgot-password {

            margin-top: 1.5rem; /* Increased margin */

            font-size: 0.95rem; /* Slightly larger font */

        }



        .forgot-password a {

            color: var(--primary);

            text-decoration: none;

            font-weight: 500;

            transition: color 0.2s ease;

        }



        .forgot-password a:hover {

            text-decoration: underline;

            color: var(--primary-dark);

        }



        /* Keyframe Animations (copied from School Site.html for consistency) */

        @keyframes fadeIn {

            from { opacity: 0; }

            to { opacity: 1; }

        }



        @keyframes slideInFromTop {

            from { transform: translateY(-20px); opacity: 0; }

            to { transform: translateY(0); opacity: 1; }

        }



        @keyframes popIn {

            from { transform: scale(0.9); opacity: 0; }

            to { transform: scale(1); opacity: 1; }

        }



        /* Modal Styles */

        .modal-overlay {

            position: fixed;

            top: 0;

            left: 0;

            width: 100%;

            height: 100%;

            background-color: rgba(0, 0, 0, 0.65); /* Slightly darker overlay */

            display: flex;

            justify-content: center;

            align-items: center;

            z-index: 1000;

            opacity: 0;

            visibility: hidden;

            transition: opacity 0.3s ease, visibility 0.3s ease;

        }



        .modal-overlay.active {

            opacity: 1;

            visibility: visible;

        }



        .modal-content {

            background-color: #ffffff;

            padding: 3rem; /* Increased padding */

            border-radius: 1.25rem; /* More rounded */

            box-shadow: var(--modal-shadow); /* Stronger shadow */

            width: 100%;

            max-width: 450px; /* Slightly wider */

            text-align: center;

            transform: translateY(-30px); /* More pronounced slide-in */

            transition: transform 0.3s ease;

            position: relative; /* For close button positioning */

        }



        .modal-overlay.active .modal-content {

            transform: translateY(0);

        }



        .modal-close-button {

            position: absolute;

            top: 1.25rem; /* Adjusted position */

            right: 1.25rem;

            background: none;

            border: none;

            font-size: 1.75rem; /* Larger icon */

            color: var(--gray-medium);

            cursor: pointer;

            transition: color 0.2s ease;

        }



        .modal-close-button:hover {

            color: var(--gray-dark);

        }



        .modal-content h2 {

            font-size: 2rem; /* Larger font size */

            font-weight: 700;

            color: var(--primary-dark);

            margin-bottom: 1.75rem; /* Increased margin */

        }



        .modal-content p {

            color: var(--gray-dark);

            margin-bottom: 1.75rem; /* Increased margin */

            line-height: 1.6; /* Improved readability */

        }



        .modal-content .form-group {

            margin-bottom: 1.75rem; /* Increased margin */

        }



        .modal-content .login-button {

            margin-top: 1.5rem; /* Increased margin */

        }



        /* School Site UI Specific Styles */

        #school-site-ui {

            display: none; /* Initially hidden */

            width: 100%;

            height: 100vh;

            overflow: hidden; /* Ensure no scrollbars on the main body */

            background-color: var(--light);

            color: var(--dark);

        }



        /* General transitions for smoother UI */

        .sidebar, .nav-item, .module-card, .notification-dropdown, .view-all-modal, .tab, .user-dropdown, .fc-button {

            transition: all 0.3s ease-in-out;

        }



        /* Custom Keyframe Animations */

        @keyframes fadeIn {

            from { opacity: 0; }

            to { opacity: 1; }

        }



        @keyframes slideInFromLeft {

            from { transform: translateX(-20px); opacity: 0; }

            to { transform: translateX(0); opacity: 1; }

        }



        @keyframes slideInFromTop {

            from { transform: translateY(-20px); opacity: 0; }

            to { transform: translateY(0); opacity: 1; }

        }



        @keyframes popIn {

            from { transform: scale(0.9); opacity: 0; }

            to { transform: scale(1); opacity: 1; }

        }



        /* Apply animations */

        .animate-fadeIn {

            animation: fadeIn 0.5s ease-out forwards;

        }

        .animate-slideInFromLeft {

            animation: slideInFromLeft 0.4s ease-out forwards;

        }

        .animate-slideInFromTop {

            animation: slideInFromTop 0.4s ease-out forwards;

        }

        .animate-popIn {

            animation: popIn 0.3s ease-out forwards;

        }



        /* Sidebar Styling */

        .sidebar {

            background-color: #ffffff; /* White background */

            box-shadow: var(--card-shadow); /* Subtle shadow */

            padding-top: 1.5rem; /* Increased padding */

        }

        .sidebar .logo-section {

            padding: 0 1.5rem 1.5rem; /* Adjusted padding */

            border-bottom: 1px solid var(--gray-light);

            margin-bottom: 1.5rem;

        }

        .sidebar .logo-section img {

            width: 48px; /* Consistent size */

            height: 48px;

        }

        .sidebar .logo-section h1 {

            font-size: 1.35rem; /* Adjusted font size */

            color: var(--primary-dark);

        }

        .sidebar .nav-section h3 {

            font-size: 0.75rem; /* Smaller uppercase text */

            color: var(--gray-medium);

            margin-bottom: 0.75rem;

            padding: 0 1.5rem; /* Align with nav items */

        }

        .sidebar .nav-item {

            color: var(--gray-dark);

            padding: 0.85rem 1.5rem; /* Increased padding */

            border-radius: 0.75rem; /* More rounded corners */

            display: flex;

            align-items: center;

            gap: 1rem; /* Increased space */

            font-weight: 500;

            margin: 0.25rem 0.75rem; /* Add horizontal margin for rounded effect */

        }

        .sidebar .nav-item i {

            font-size: 1.15rem; /* Slightly larger icons */

            color: var(--gray-medium);

        }

        .sidebar .nav-item:hover {

            background-color: #F3F4F6; /* Light gray on hover */

            color: var(--primary-dark);

        }

        .sidebar .nav-item:hover i {

            color: var(--primary);

        }

        .sidebar .nav-item.active {

            background-color: #EEF2FF; /* Light indigo background */

            border-left: 4px solid var(--primary); /* Primary color border */

            color: var(--primary-dark);

            font-weight: 600;

            margin-left: 0; /* Remove left margin for active item to align border */

            border-top-left-radius: 0;

            border-bottom-left-radius: 0;

        }

        .sidebar .nav-item.active i {

            color: var(--primary);

        }



        /* Module Card Styling */

        .module-card {

            background-color: #ffffff;

            border-radius: 1rem; /* More rounded corners */

            box-shadow: var(--card-shadow); /* Subtle initial shadow */

            transition: all 0.2s ease-in-out;

            border: 1px solid transparent; /* For hover effect */

        }

        .module-card:hover {

            transform: translateY(-6px); /* More pronounced lift */

            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12); /* Stronger shadow on hover */

            border-color: var(--primary); /* Highlight border on hover */

        }

        .module-card .icon-wrapper {

            padding: 0.85rem; /* Increased padding */

            border-radius: 0.75rem; /* More rounded */

            display: inline-flex;

            align-items: center;

            justify-content: center;

            font-size: 1.35rem; /* Larger icons */

        }



        /* Top Bar Styling */

        header {

            background-color: #ffffff;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);

            padding: 1.25rem 2rem; /* Increased padding */

            border-bottom: 1px solid var(--gray-light);

        }

        header h2 {

            font-size: 1.6rem; /* Larger title */

            font-weight: 600;

            color: var(--dark);

        }



        /* Notification Dropdown Styles */

        .notification-dropdown {

            position: absolute;

            top: 70px; /* Adjusted for better alignment */

            right: 25px;

            background-color: white;

            border-radius: 1rem; /* Consistent rounding */

            box-shadow: var(--modal-shadow); /* Stronger shadow */

            width: 350px; /* Slightly wider */

            max-height: 450px; /* Taller */

            overflow-y: auto;

            z-index: 1000;

            opacity: 0;

            transform: translateY(-20px); /* More pronounced slide-down */

            transition: opacity 0.3s ease-out, transform 0.3s ease-out;

            pointer-events: none;

            border: 1px solid var(--border-color);

        }

        .notification-dropdown.active {

            opacity: 1;

            transform: translateY(0);

            pointer-events: auto;

        }

        .notification-dropdown .header {

            padding: 1rem 1.5rem;

            border-bottom: 1px solid var(--gray-light);

            font-weight: 600;

            font-size: 1.1rem;

            color: var(--dark);

        }

        .notification-item {

            padding: 14px 1.5rem; /* Increased padding */

            border-bottom: 1px solid #F3F4F6;

            cursor: pointer;

            transition: background-color 0.15s ease;

        }

        .notification-item:last-child {

            border-bottom: none;

        }

        .notification-item.unread {

            background-color: #EEF2FF; /* Light indigo for unread */

        }

        .notification-item:hover {

            background-color: #F9FAFB;

        }

        .notification-item.unread:hover {

            background-color: #E0E7FF; /* Slightly darker indigo on hover */

        }

        .notification-item .title {

            font-weight: 600;

            color: var(--gray-dark);

            margin-bottom: 6px; /* Increased margin */

            font-size: 0.95rem;

        }

        .notification-item .time {

            font-size: 0.7rem; /* Slightly smaller */

            color: var(--gray-medium);

        }

        .notification-footer {

            padding: 1rem 1.5rem;

            display: flex;

            justify-content: space-between;

            align-items: center;

            border-top: 1px solid #F3F4F6;

        }

        .notification-footer button, .notification-footer a {

            color: var(--primary);

            font-weight: 500;

            font-size: 0.9rem;

        }

        .notification-footer button:hover, .notification-footer a:hover {

            text-decoration: underline;

            color: var(--primary-dark);

        }



        /* View All Notifications Modal Styles */

        .view-all-modal {

            position: fixed;

            inset: 0;

            background: rgba(0, 0, 0, 0.7); /* Darker overlay */

            display: flex;

            justify-content: center;

            align-items: center;

            z-index: 1100;

            opacity: 0;

            pointer-events: none;

            transition: opacity 0.3s ease-out;

        }

        .view-all-modal.active {

            opacity: 1;

            pointer-events: auto;

        }

        .view-all-content {

            background: white;

            border-radius: 1.25rem; /* Even more rounded */

            width: 90%;

            max-width: 600px; /* Wider */

            max-height: 90vh; /* Taller */

            overflow-y: auto;

            box-shadow: var(--modal-shadow); /* Stronger shadow */

            display: flex;

            flex-direction: column;

            transform: scale(0.9); /* More pronounced scale animation */

            transition: transform 0.3s ease-out;

            border: 1px solid var(--border-color);

        }

        .view-all-modal.active .view-all-content {

            transform: scale(1);

        }

        .view-all-header {

            padding: 1.25rem 2rem; /* Increased padding */

            border-bottom: 1px solid var(--gray-light);

            display: flex;

            justify-content: space-between;

            align-items: center;

        }

        .view-all-header h3 {

            font-size: 1.75rem; /* Larger title */

            font-weight: 700; /* Bolder */

            color: var(--dark);

        }

        .view-all-header button {

            background: none;

            border: none;

            cursor: pointer;

            font-size: 2rem; /* Larger close ic
