/********************************
* Google Assistant IO
* Device Code
* Cut and paste this to your Device Section
********************************/

const APP_NAME = "SIMPLE-IO-CONTROL";
const APP_CODE = "GOOG-ASSISTANT-IO";
const APP_TZONE = 28800; //+8hours, Timezone (not in use for now)

//Reset nodes
hardware.pin1.configure(ANALOG_IN);//Some input, sugested LDR
hardware.pin2.configure(ANALOG_IN);//Some input, suggested Doppler Radar
hardware.pin5.configure(DIGITAL_OUT);//White Led
hardware.pin9.configure(PWM_OUT, 1.0/200, 0);//RGB led
hardware.pin8.configure(PWM_OUT, 1.0/200, 0);//RGB led
hardware.pin7.configure(PWM_OUT, 1.0/200, 0);//RGB led
local dt = date(time()+APP_TZONE, 'l');

local pin1in = 0.0; 
local pin2in = 0.0; 
local pin5out = 0; 
local pin9out = 0.0; 
local pin8out = 0.0; 
local pin7out = 0.0; 

function watchdog() {
    imp.wakeup(1*120, watchdog);
    server.log("keep alive");
}

function set_pin(){
    server.log("DEVICE:P5:"+pin5out+",P9:"+pin9out+",P8:"+pin8out+",P7:"+pin7out);
    pin1in = hardware.pin1.read();
    pin2in = hardware.pin2.read();    
    hardware.pin5.write(pin5out);
    hardware.pin9.write(pin9out);
    hardware.pin8.write(pin8out);    
    hardware.pin7.write(pin7out);
}

/*From IFTTT -> agent -> device -> LED */
agent.on("set", function(state){
    
    foreach (key,val in state){

        server.log("Parse: "+key+"="+val);
        
        if(key=="P5"){
            if(val==1){
                pin5out = 1;
            }else{
                pin5out = 0;
            }
        }

        if(key=="P9"){
            if(val<=1 && val>=0){
                pin9out = val;
            }else{
                if(val<=100 && val>1){
                     pin9out = val/100.1;//make it below 1 (preferable not to output 100%)
                }else{
                    pin9out = 0;
                }
            }
        }
        
        if(key=="P8"){
            if(val<=1 && val>=0){
                pin8out = val;
            }else{
                if(val<=100 && val>1){
                     pin8out = val/100.1;
                }else{
                    pin8out = 0;
                }
            }
        }  
        
       if(key=="P7"){
            if(val<=1 && val>=0){
                pin7out = val;
            }else{
                if(val<=100 && val>1){
                     pin7out = val/100.1;
                }else{
                    pin7out = 0;
                }
            }
        }
        
    }     
    
    set_pin();
    
});

//keep wifi alive
watchdog();
