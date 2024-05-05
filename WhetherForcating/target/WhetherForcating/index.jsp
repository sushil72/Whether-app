<%@page contentType="text/html; charset=UTF-8" %>
<%@page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="output.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500&family=Oxygen+Mono&display=swap"
        rel="stylesheet" />
    <title>Whether ForeCast</title>
</head>

<body class="bg-gray-200 flex justify-center ">


    <div class="w-1/2 h-screen  text-gray-700  flex flex-col">
        <div class="container flex justify-between mt-10 border w-full p-3">
            <form class="border space-x-4 " action="servlet" method="POST">
                <input type="text"  name="city" placeholder="Search your city...."
                    class="px-3 py-1 rounded-md border border-black focus:outline-none w-80">
                <button type="submit"
                    class="border border-black  px-4 py-1 bg-yellow-500 text-black rounded-md   hover:bg-yellow-600 ">Search</button>
            </form>


            <div class="">
                <h1 class="text-4xl font-bold">${city}</h1>
            </div>
        </div>

        <div id="mode" class="ml-3">
            <span class="measurements text-blue-500 text-xl ">
                <a href="#" id="celcius-link" class="hover:underline">C°</a> |
                <a href="#" id="fahrenheit-link" class="hover:underline">F°</a>
            </span>
        </div>

        <div class="w-full flex justify-between p-5 mt-10">
            <div class="temperature">
                <h1 id="temperature" class="text-9xl font-semibold">${temperature}°</h1>
            </div>
            <div class="day w-1/2">
                <p id="time" class="mt-2 font-oxygen text-sm">${time}</p>
                <p id="day" class="text-5xl mt-3 font-semibold">${dayOfWeek}</p>
                <p id="type" class="font-oxygen mt-2 text-sm">${weatherCondition}</p>
            </div>
            <div class="humidity font-oxygen text-sm p-2">
                <p id="humidity" class="mt-6">Humidity : ${humidity}%</p>
                <p id="wind" class="mt-3">Wind : ${windSpeed} km/h</p>
            </div>
        </div>

        <div class="border border-b border-gray-500 w-full mt-14"></div>

        <div class="flex justify-between">
            <div class=" p-10 container ">
                <h3 class="text-3xl font-semibold">Fri</h3>
                <br>
                <img src="https://img.icons8.com/color-glass/42/000000/rain.png"
                alt="" class="-mt-4">
                <br>
                <p class="-mt-4">Rain</p>
                <span class="text-2xl">2°</span>
            </div>

            <div class=" p-10 container ">
                <h3 class="text-3xl font-semibold">Sat</h3>
                <br>
                <img src="https://img.icons8.com/color-glass/42/000000/cloud.png"
                alt="" class="-mt-4">
                <br>
                <p class="-mt-4">Rain</p>
                <span class="text-2xl">4°</span>
            </div>

            <div class=" p-10 container ">
                <h3 class="text-3xl font-semibold">Sun</h3>
                <br>
                <img src="https://img.icons8.com/color-glass/42/000000/partly-cloudy-day.png"

                alt="" class="-mt-4">
                <br>
                <p class="-mt-4">Rain</p>
                <span class="text-2xl">6°</span>
            </div>

            <div class=" p-10 container ">
                <h3 class="text-3xl font-semibold">Mon</h3>
                <br>
                <img  src="https://img.icons8.com/color-glass/42/000000/sun.png"

                alt="" class="-mt-4">
                <br>
                <p class="-mt-4">Rain</p>
                <span class="text-2xl">8°</span>
            </div>

            <div class=" p-10 container ">
                <h3 class="text-3xl font-semibold">Tue</h3>
                <br>
                <img src="https://img.icons8.com/color-glass/42/000000/wind.png"

                alt="" class="-mt-4">
                <br>
                <p class="-mt-4">Rain</p>
                <span class="text-2xl">5°</span>
            </div>
        </div>



    </div>

<script>
    let celciusLink = document.getElementById("celcius-link");
    let fahrenheitLink = document.getElementById("fahrenheit-link");
    let temperatureElement = document.getElementById("temperature");
    let celsiusTemperature = parseInt(temperatureElement.innerHTML);
    fahrenheitLink.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent default behavior of anchor tag

        // Parse the current Celsius temperature from the innerHTML of the temperature element
        // let celsiusTemperature = parseInt(temperatureElement.innerHTML);

        // Convert Celsius to Fahrenheit
        let fahrenheitTemperature = (celsiusTemperature * 9/5) + 32;

        // Update the temperature display with the converted value
        temperatureElement.innerHTML = Math.round(fahrenheitTemperature.toFixed(2)) + "°F";
    });

    celciusLink.addEventListener('click',function (event)
    {
        temperatureElement.innerHTML=celsiusTemperature+"°";
    })

</script>
</body>

</html>