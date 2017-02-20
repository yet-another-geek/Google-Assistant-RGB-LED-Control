/********************************
* Google Assistant IO
* Agent Code
* Cut and paste this to your Agent Section
********************************/

//INPUT from IFTTT
http.onrequest(function(request, response) {

    //DEBUG USE
    foreach(idx,val in request.query){
        server.log("Received GET["+idx+"]="+val);
    }
     
    local statm = "OK";

    if("color" in request.query)
    {
        //P9 Blue - P8 Green - P7 Red
        local state = "{\"P9\":0,\"P8\":0,\"P7\":0}";
        
        if(request.query["color"]=="blue"){
            state = "{\"P9\":100,\"P8\":0,\"P7\":0}";
        }
        
        if(request.query["color"]=="green"){
            state = "{\"P9\":0,\"P8\":100,\"P7\":0}";
        }
        
        if(request.query["color"]=="red"){
            state = "{\"P9\":0,\"P8\":0,\"P7\":100}";
        } 
        
        if(request.query["color"]=="pink"){
            state = "{\"P9\":60,\"P8\":0,\"P7\":100}";
        }  
        
        if(request.query["color"]=="orange"){
            state = "{\"P9\":10,\"P8\":10,\"P7\":100}";
        }
        
        if(request.query["color"]=="yellow"){
            state = "{\"P9\":0,\"P8\":100,\"P7\":100}";
        }        
        
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass param to the device
        server.log("color = "+state);
    }    
    
    
    if("R1" in request.query)
    {
        local state = "{\"P9\":"+request.query["R1"]+"}";
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass it to the device
        server.log("R1 = "+state);
    }

    if("R2" in request.query)
    {
        local state = "{\"P8\":"+request.query["R2"]+"}";
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass it to the device
        server.log("R2 = "+state);
    }
    
    //INPUT
    if("R3" in request.query)
    {
        local state = "{\"P7\":"+request.query["R3"]+"}";
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass it to the device
        server.log("R3 = "+state);
    }
    
    //INPUT On/Off
    if("R4" in request.query)
    {
        local state = "{\"P5\":"+request.query["R4"]+"}";
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass it to the device
        server.log("R4 = "+state);
    }    
    
    //INPUT
    if("set" in request.query)
    {
        //tunnel the json string to device
        local state = request.query["set"];
        local tbl = http.jsondecode(state);
        device.send("set", tbl ); // pass it to the device
    }

   // send a response back.. 
   response.send(200, statm);
});
