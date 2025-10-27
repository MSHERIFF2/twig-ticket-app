<?php
require_once __DIR__ . '/../vendor/autoload.php';

$loader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../templates');
$twig = new \Twig\Environment($loader);

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// Basic routing
switch ($uri) {
    case '/':
    case '/home':
        echo $twig->render('home.twig', ['title' => 'TicketApp']);
        break;

    case '/auth/login':
        echo $twig->render('auth-login.twig', ['title' => 'Login']);
        break;
    case '/dashboard':
    echo $twig->render('dashboard.twig', ['title' => 'Dashboard']);
    break;
    case '/tickets':
    echo $twig->render('tickets.twig', ['title' => 'Tickets']);
    break;



    case '/auth/signup':
        echo $twig->render('auth-signup.twig', ['title' => 'Signup']);
        break;

    default:
        http_response_code(404);
        echo $twig->render('404.twig', ['title' => 'Page Not Found']);
        break;
}
