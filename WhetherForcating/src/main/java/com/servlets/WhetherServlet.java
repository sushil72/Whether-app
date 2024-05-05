package com.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;
import java.util.Date;

@WebServlet("/servlet")
public class WhetherServlet extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String city = req.getParameter("city");
//        System.out.println(city);

        String ApiKey="206e636f264872abda3dccf30217772e";
        String APIUrl = "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+ApiKey;

        //API Integration
try {

    URL url = new URL(APIUrl);
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");
    //Reading the data from network
    InputStream inputStream = con.getInputStream();
    InputStreamReader reader = new InputStreamReader(inputStream);
   //Want to stroe data in string String builder because strings are immutable and we have to change the string value each time
    StringBuilder responseContent = new StringBuilder();
    Scanner scanner = new Scanner(reader);

    while (scanner.hasNextLine()) {
        responseContent.append(scanner.nextLine());
    }
    scanner.close();
//    System.out.println(responseContent);

    //Type Casting

    Gson gson = new Gson();
    JsonObject jsonObject = gson.fromJson(responseContent.toString(), JsonObject.class);

    //date & time
    long DateTimeStamp = jsonObject.get("dt").getAsLong()*1000;
    String Date = new Date(DateTimeStamp).toString();

    // Convert the Unix timestamp to LocalDateTime
    Instant instant = Instant.ofEpochMilli(DateTimeStamp);
    LocalDateTime dateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());

// Format LocalDateTime to display only the time (hours, minutes, seconds)
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
    String time = dateTime.format(formatter);

//    System.out.println("Time extracted from JSON object: " + time);

    //Temperature
    double temperatureKelvin = jsonObject.getAsJsonObject("main").get("temp").getAsDouble();
    int tempCelcius= (int) (temperatureKelvin - 273.15);

    //Humidity
    int humidity = jsonObject.getAsJsonObject("main").get("humidity").getAsInt();

    // wind Speed

    double WindSpeed = jsonObject.getAsJsonObject("wind").get("speed").getAsDouble();

    // Weather Condition
    String weatherCondition = ""; // Initialize to empty string
    if (jsonObject.has("weather") && jsonObject.get("weather").isJsonArray()) {
        JsonArray weatherArray = jsonObject.getAsJsonArray("weather");
        if (weatherArray.size() > 0) {
            JsonObject weatherObject = weatherArray.get(0).getAsJsonObject();
            if (weatherObject.has("description")) {
                weatherCondition = weatherObject.get("description").getAsString();
            }
        }
    }

    String dayOfWeek = dateTime.getDayOfWeek().toString();

    System.out.println(jsonObject);

    // Set the data as request attributes (for sending to the jsp page)
    req.setAttribute("date", Date);
    req.setAttribute("time", time);
    req.setAttribute("city", city);
    req.setAttribute("temperature", tempCelcius);
    req.setAttribute("weatherCondition", weatherCondition);
    req.setAttribute("humidity", humidity);
    req.setAttribute("windSpeed", WindSpeed);
    req.setAttribute("weatherData", responseContent.toString());
    req.setAttribute("dayOfWeek", dayOfWeek); // Set day of the week attribute

    con.disconnect();


}catch (Exception e){
    e.printStackTrace();

}
        req.getRequestDispatcher("index.jsp").forward(req, res);


    }
}
