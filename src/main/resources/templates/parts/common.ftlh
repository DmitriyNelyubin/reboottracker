<#macro page>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>RebootTracker</title>
        <link rel="stylesheet" href="">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="/webjars/bootstrap/4.5.1/dist/css/bootstrap.min.css">
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </head>
    <body>
    <#include "navbar.ftlh">
    <div class="container mt-5">
        <#nested>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="/webjars/jquery/3.5.1/dist/jquery.min.js"></script>
    <script src="/webjars/popper.js/1.16.0/dist/umd/popper.min.js"></script>
    <script src="/webjars/bootstrap/4.5.1/dist/js/bootstrap.min.js"></script>
    </body>
    </html>
</#macro>