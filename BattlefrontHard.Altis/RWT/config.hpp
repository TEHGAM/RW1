class RWT
{
	tag = "RWT";
	class forPlayers {
		file = "RWT\functions\forPlayers";
		class initPlayer {recompile = 1;};
		class getNades {recompile = 1;};
		class switchNade {recompile = 1;};
		class fireCurrentNade {recompile = 1;};
	};
	class forWeapons {
		file = "RWT\functions\forWeapons";
		class getFiremodeToPic {recompile = 1;};
		class limitArsenal {recompile = 1;};
	};
	class forVehicles {
		file = "RWT\functions\forVehicles";
		class initVehicle {recompile = 1;};
		class enableLaserGuide {recompile = 1;};
	};
	class forArrays {
		file = "RWT\functions\forArrays";
		class arrayRotate {recompile = 1;};
	};
	class forControls {
		file = "RWT\functions\forControls";
		class keyDown {recompile = 1;};
	};
};