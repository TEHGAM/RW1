cutText ["Режим бога выключен", "PLAIN"];
player removeAllEventHandlers "handleDamage";
player addEventHandler ["handleDamage", {true}];
	player removeAction line1;
	player removeAction line2;
	player removeAction godmode;
	player removeAction tele;
	player removeAction guns;
	player removeAction mainveh;
	player removeAction cgod;
	player removeAction hplay;