enableSaving [false, false];
enableEngineArtillery false;

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
player addEventHandler ["HandleRating",{0}];

/*player addEventHandler ["Take",{_this call uo_common_fnc_handleTakeRadio}];*/
/*player addEventHandler ["Take",{_this call uo_common_fnc_handleScopeChange}];*/

// raise radio range as we have only sw
player setVariable ["tf_receivingDistanceMultiplicator", 1];
player setVariable ["tf_sendingDistanceMultiplicator", 1];


// CUSTOM ANIMATIONS
if ((side player) == east) then {
	player addAction [
        "<t color='#FF0000'>cheeki breeki iv damke</t>", 
        "functions\common\fn_animSquat.sqf",
        nil,
        0,
        false,
        true,
        "",
        "(vehicle _this == _this) && !(_this getVariable ['mitm_animationRunning', false]) && speed _this < 1 && stance player == 'stand'"
        ];
};

if ((side player) == west) then {
    player addAction [
        "<t color='#FF0000'>relax</t>", 
        "functions\common\fn_animRelax.sqf",
        nil,
        0,
        false,
        true,
        "",
        "(vehicle _this == _this) && !(_this getVariable ['mitm_animationRunning', false]) && speed _this < 1 && stance player == 'stand'"
        ];
};


if ((side player) == independent) then {
    player addAction [
        "<t color='#FF0000'>dance</t>", 
        "functions\common\fn_animDance.sqf",
        nil,
        0,
        false,
        true,
        "",
        "(vehicle _this == _this) && !(_this getVariable ['mitm_animationRunning', false]) && speed _this < 1 && stance player == 'stand'"
        ];
};

if ((side player) == civilian) then {
    player addAction [
        "<t color='#FF0000'>dance</t>", 
        "functions\common\fn_animDance2.sqf",
        nil,
        0,
        false,
        true,
        "",
        "(vehicle _this == _this) && !(_this getVariable ['mitm_animationRunning', false]) && speed _this < 1 && stance player == 'stand'"
        ];
};

player addMPEventHandler ["MPHit", {
    params ["_unit", "_causedBy", "_damage", "_instigator"];

    if (animationState _unit == toLower "Acts_Executioner_Squat") then {
        [_unit, ""] remoteExec ["switchMove", 0];
        _unit setVariable ["mitm_animationRunning", false, true];
    };

    if (animationState _unit == toLower "Acts_Ambient_Relax_4") then {
        [_unit, ""] remoteExec ["switchMove", 0];
        _unit setVariable ["mitm_animationRunning", false, true];
    };

    if (animationState _unit == toLower "Acts_Dance_01") then {
        [_unit, ""] remoteExec ["switchMove", 0];
        _unit setVariable ["mitm_animationRunning", false, true];
    };

    if (animationState _unit == toLower "Acts_Dance_02") then {
        [_unit, ""] remoteExec ["switchMove", 0];
        _unit setVariable ["mitm_animationRunning", false, true];
    };    
}];


player addEventHandler ["AnimDone", {
    params ["_unit", "_anim"];

    // hint str _anim;

    if (_anim == toLower "Acts_Executioner_Squat") then {
        [_unit] remoteExec ["mitm_common_fnc_animSquatEnd", 0];
    };

    if (_anim == toLower "Acts_Executioner_Squat_End") then {
        [_unit, ""] remoteExec ["switchMove", 0];
    };

    if (_anim == toLower "Acts_Ambient_Relax_4") then {
        _unit setVariable ["mitm_animationRunning", false];
    };

    if (_anim == toLower "Acts_Dance_01") then {
        _unit setVariable ["mitm_animationRunning", false];
        [_unit, ""] remoteExec ["switchMove", 0];
    };

    if (_anim == toLower "Acts_Dance_02") then {
        _unit setVariable ["mitm_animationRunning", false];
        [_unit, ""] remoteExec ["switchMove", 0];
    };    
}];


[{
    !(isNull (findDisplay 46))
},{
    (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["", "_keycode"];

    if (_keycode in [17,30,31,32]) then {

            if (animationState player in [toLower "Acts_Executioner_Squat"]) then {
                [player] remoteExec ["mitm_common_fnc_animSquatEnd", 0];
            };

            if (animationState player in [toLower "Acts_Ambient_Relax_4"]) then {
                [player] remoteExec ["mitm_common_fnc_animRelaxEnd", 0];
            };

            if (animationState player in [toLower "Acts_Dance_01"]) then {
                [player] remoteExec ["mitm_common_fnc_animDanceEnd", 0];
            };

            if (animationState player in [toLower "Acts_Dance_02"]) then {
                 [player] remoteExec ["mitm_common_fnc_animDanceEnd", 0];
            };            
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;
