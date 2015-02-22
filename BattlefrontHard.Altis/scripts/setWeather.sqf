_weather = _this select 0;

skipTime -24;

_pingTime = 24*60*60;
switch (_weather) do {
	case 0: { //Ñlear
		_pingTime setOvercast 0.1;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0;
		_pingTime setWindForce 0;
		_pingTime setWaves 0.1;
		_pingTime setLightnings 0;
	};
	case 1: { //Ñlear (Light Winds)
		_pingTime setOvercast 0.1;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0.25;
		_pingTime setWindForce 0.5;
		_pingTime setWaves 0.5;
		_pingTime setLightnings 0;
	};
	case 2: { //Ñlear (Strong Winds)
		_pingTime setOvercast 0.1;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0.75;
		_pingTime setWindForce 1;
		_pingTime setWaves 1;
		_pingTime setLightnings 0;
	};
	case 3: { //Cloudiness
		_pingTime setOvercast 0.5;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0;
		_pingTime setWindForce 0;
		_pingTime setWaves 0.1;
		_pingTime setLightnings 0;
	};
	case 4: { //Cloudiness (Light Winds)
		_pingTime setOvercast 0.5;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0.25;
		_pingTime setWindForce 0.5;
		_pingTime setWaves 0.5;
		_pingTime setLightnings 0;
	};
	case 5: { //Cloudiness (Strong Winds)
		_pingTime setOvercast 0.5;
		_pingTime setFog 0;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0.75;
		_pingTime setWindForce 1;
		_pingTime setWaves 1;
		_pingTime setLightnings 0;
	};
	case 6: { //Rain
		_pingTime setOvercast 0.8;
		_pingTime setFog 0;
		_pingTime setRain 1;
		_pingTime setRainbow 0.2;
		_pingTime setWindStr 0;
		_pingTime setWindForce 0;
		_pingTime setWaves 0;
		_pingTime setLightnings 0;
	};
	case 7: { //Rain (Light Winds)
		_pingTime setOvercast 0.8;
		_pingTime setFog 0;
		_pingTime setRain 1;
		_pingTime setRainbow 0.2;
		_pingTime setWindStr 0.25;
		_pingTime setWindForce 0.5;
		_pingTime setWaves 0.5;
		_pingTime setLightnings 0;
	};
	case 8: { //Rain (Strong Winds)
		_pingTime setOvercast 0.8;
		_pingTime setFog 0;
		_pingTime setRain 1;
		_pingTime setRainbow 0.2;
		_pingTime setWindStr 0.75;
		_pingTime setWindForce 1;
		_pingTime setWaves 1;
		_pingTime setLightnings 0;
	};
	case 9: { //Storm
		_pingTime setOvercast 1;
		_pingTime setFog 0;
		_pingTime setRain 1;
		_pingTime setRainbow 0;
		_pingTime setWindStr 1;
		_pingTime setWindForce 1;
		_pingTime setWaves 1;
		_pingTime setLightnings 1;
	};
	case 10: { //Light Fog
		_pingTime setOvercast 0.25;
		_pingTime setFog 0.25;
		_pingTime setRain 0;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0;
		_pingTime setWindForce 0;
		_pingTime setWaves 0;
		_pingTime setLightnings 0;
	};
	case 11: { //Heavy Fog
		_pingTime setOvercast 0.75;
		_pingTime setFog 0.75;
		_pingTime setRain 1;
		_pingTime setRainbow 0;
		_pingTime setWindStr 0;
		_pingTime setWindForce 0;
		_pingTime setWaves 0;
		_pingTime setLightnings 0;
	};
};

skipTime 24;

sleep 1;
simulWeatherSync;