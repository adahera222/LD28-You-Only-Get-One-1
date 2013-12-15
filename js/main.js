var content, getCombatBasedOnStrength, getContentFor, getStatBarClass, leetHax0rMode, maxDamageFactor, maxEnemyHealthPerDifficulty, maxEnemyStrengthPerDifficulty, maxHealPerSanity, maxInitialHealth, maxInitialSanity, maxInitialStrength, minDamageFactor, minEnemyHealthPerDifficulty, minEnemyStrengthPerDifficulty, minHealPerSanity, minInitialHealth, minInitialSanity, minInitialStrength, randBetween, randIntBetween;

content = [];

_.templateSettings = {
  interpolate: /\{\{(.+?)\}\}/g
};

leetHax0rMode = false;

minInitialHealth = 90;

maxInitialHealth = 110;

minInitialStrength = 90;

maxInitialStrength = 110;

minInitialSanity = 90;

maxInitialSanity = 110;

minEnemyHealthPerDifficulty = 20;

maxEnemyHealthPerDifficulty = 30;

minDamageFactor = 0.4;

maxDamageFactor = 0.6;

minEnemyStrengthPerDifficulty = 20;

maxEnemyStrengthPerDifficulty = 30;

minHealPerSanity = 0.3;

maxHealPerSanity = 0.5;

randBetween = function(min, max) {
  return Math.random() * (max - min) + min;
};

randIntBetween = function(min, max) {
  return Math.round(randBetween(min, max));
};

getStatBarClass = function(value) {
  if (value > 90) {
    return "progress-bar-success";
  } else if (value > 70) {
    return "progress-bar-info";
  } else if (value > 50) {
    return "";
  } else if (value > 25) {
    return "progress-bar-warning";
  } else {
    return "progress-bar-danger";
  }
};

getContentFor = function(day, phase) {
  var currentDay, currentPhase;
  currentDay = content[day];
  currentPhase = currentDay[phase];
  return currentPhase;
};

getCombatBasedOnStrength = function(strength, enemyDifficulty) {
  var damage, enemyDamage, enemyHealth, enemyStrength, numberOfStrikes;
  enemyHealth = enemyDifficulty * randIntBetween(minEnemyHealthPerDifficulty, maxEnemyHealthPerDifficulty);
  enemyStrength = enemyDifficulty * randIntBetween(minEnemyStrengthPerDifficulty, maxEnemyStrengthPerDifficulty);
  damage = strength * randBetween(minDamageFactor, maxDamageFactor);
  enemyDamage = enemyStrength * randBetween(minDamageFactor, maxDamageFactor);
  numberOfStrikes = enemyHealth / damage;
  return {
    damage: Math.round(numberOfStrikes * enemyDamage),
    insanity: Math.round(numberOfStrikes)
  };
};

content[0] = {
  start: {
    text: "You are sitting in an open field.  There is a campfire in front of you.  It burns slowly and is quite comforting.  The fire illuminates a rather large area; you can see that nothing is trying to eat you. Fortunately for you, it's daytime, so the fire is rather pointless for lighting.  You can see in the distance the gate of a mountain fortress; you remember that your town leaders decreed that this fortress would be the place of refuge for everyone in case of an emergency like this one.  But the night is fast approaching and you have little time before nightfall.  You are in pristine condition; you've never felt better despite the rather bizarre turn of events that has preceded this moment.",
    choices: [
      {
        text: "Next",
        icon: "fa-arrow-right",
        action: function(player) {
          return player.setPhase("nightfall");
        }
      }
    ]
  },
  nightfall: {
    text: "As night falls, you see some vague shapes; they seem to be avoiding the light from your campfire. Although you can't tell for certain, you would guess that there are three of them present.  They seem rather weak and somewhat vulnerable.  You reach for your trusted dagger and find it reassuringly attached to your belt.  You weigh your options and come to the conclusion that it would be feasible to attempt to drive the creatures off now.",
    choices: [
      {
        text: "Attack the creatures",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1);
          return player.setPhase("aggressive");
        }
      }, {
        text: "Leave them alone",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("nonaggressive");
        }
      }
    ]
  },
  nonaggressive: {
    text: "You sit by the fire and the creatures do not move towards you.  You are growing tired.  They might be peaceful, or they might be waiting for a chance to attack you.",
    choices: [
      {
        text: "Sleep for the rest of the night",
        icon: "fa-moon-o",
        action: function(player) {
          player.add("sanity", 10);
          player.add("strength", 2);
          player.add("health", 5);
          return player.nextDay();
        }
      }, {
        text: "Stay awake and on guard",
        icon: "fa-shield",
        action: function(player) {
          player.add("sanity", -5);
          player.add("strength", -1);
          return player.nextDay();
        }
      }
    ]
  },
  aggressive: {
    text: "As you move to attack the creatures, most of them disperse.  You are close enough now to see them in detail; their appearance is truly hideous and startles you momentarily.  One of them does not move, and as you close in, you notice in your peripheral vision that they are watching you, perhaps in an attempt to determine your strength.  You stab the creature; it bites at you.  You kill it easily; you have been a bit scratched up, but nothing too severe has happened to you.  You return to the fire, and you can see the creatures returning to where they were.</p><p>You are growing tired, but you know that they may or may not attempt to kill you in your sleep.",
    choices: [
      {
        text: "Sleep for the rest of the night",
        icon: "fa-moon-o",
        action: function(player) {
          player.add("sanity", 10);
          player.add("strength", 2);
          player.add("health", 5);
          return player.nextDay();
        }
      }, {
        text: "Stay awake and on guard",
        icon: "fa-shield",
        action: function(player) {
          player.add("sanity", -5);
          player.add("strength", -1);
          return player.nextDay();
        }
      }
    ]
  }
};

content[1] = {
  start: {
    text: "Morning arrives.  While your campfire was effective in keeping the creatures at bay before, you know that it will not last long; in fact, you can see it dwindling already.  You know that your only hope is to make for the mountain fortress and hope that someone else survived.",
    choices: [
      {
        text: "Run towards the fortress",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("running1");
        }
      }, {
        text: "Search for supplies",
        icon: "fa-shopping-cart",
        action: function(player) {
          player.add("strength", -1);
          return player.setPhase("gathering");
        }
      }
    ]
  },
  gathering: {
    text: "You find nothing in fifteen minutes of work.  There's probably a related medical condition, but you can't remember what it would be called.",
    choices: [
      {
        text: "Run towards the fortress",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("running1");
        }
      }, {
        text: "Search for more supplies",
        icon: "fa-shopping-cart",
        action: function(player) {
          player.add("strength", -1);
          return player.setPhase("stillgathering");
        }
      }
    ]
  },
  stillgathering: {
    text: "You still find nothing after another fifteen minutes.  You remembered the medical term: lazy-developer-itis.",
    choices: [
      {
        text: "Run towards the fortress",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("running1");
        }
      }, {
        text: "Search for more supplies",
        icon: "fa-shopping-cart",
        action: function(player) {
          player.add("strength", -1);
          return player.setPhase("stillgathering");
        }
      }
    ]
  },
  running1: {
    text: "You run for an hour towards the fortress.  You are impressed with your own stamina, but you know that the more you run, the weaker you will be.  Based on the approximate position of the sun, you guess that it is about noon.",
    choices: [
      {
        text: "Keep running towards the fortress",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -50);
          player.add("health", -50);
          player.add("sanity", -10);
          return player.setPhase("running2");
        }
      }, {
        text: "Stop and take a break",
        icon: "fa-home",
        action: function(player) {
          player.add("strength", 5);
          return player.setPhase("break");
        }
      }
    ]
  },
  "break": {
    text: "You stop and rest for a while.  You feel as though you may be regaining some of your strength that you lost while running.  It's getting late; you might wish to set up camp for the night.",
    choices: [
      {
        text: "Resume running towards the fortress",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -25);
          player.add("health", -20);
          player.add("sanity", -5);
          return player.setPhase("running2");
        }
      }, {
        text: "Set up camp and sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 5);
          player.add("strength", 1);
          player.add("health", 2);
          return player.setPhase("camp");
        }
      }
    ]
  },
  camp: {
    text: "You don't have very much with which to make a camp; all you've got is some brush from the ground.  You start a tiny fire to keep the creatures at bay, and then sleep.</p><p>You hear a loud noise which wakes you up.  It is very dark outside, and you can see four creatures coming towards you.",
    choices: [
      {
        text: "Stand and fight the creatures",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          return player.setPhase("donerunning");
        }
      }
    ]
  },
  running2: {
    text: "You run for another hour towards the fortress; you are so exhausted that you lose consciousness.</p><p>When you wake up, it is pitch black, and you can just barely see four creatures coming towards you.",
    choices: [
      {
        text: "Stand and fight the creatures",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1.25);
          player.takeDamageFromEnemyWithDifficulty(1.25);
          player.add("sanity", -15);
          return player.setPhase("donerunning");
        }
      }
    ]
  },
  donerunning: {
    text: "You successfully kill two of the creatures; the other two back off.  The effort has taken a significant toll on your nerves and strength; you go to sleep for a bit.",
    choices: [
      {
        text: "Pass out",
        icon: "fa-hand-o-down",
        action: function(player) {
          player.add("sanity", 3);
          player.add("strength", 1);
          player.add("health", 1);
          return player.nextDay();
        }
      }
    ]
  }
};

content[2] = {
  start: {
    text: "You are getting visibly closer to the fortress; you can see the ridges and things on the tops of the walls.  You have a good feeling about this particular day; you don't think anything weird will happen.",
    choices: [
      {
        text: "Run towards the fortress",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("awesomerunning");
        }
      }
    ]
  },
  awesomerunning: {
    text: "You run towards the fortress for half an hour.  You stop when you notice on the side of the road an old first-aid kit.",
    choices: [
      {
        text: "Use the first-aid kit",
        icon: "fa-medkit",
        action: function(player) {
          var healPer, sanity;
          sanity = player.get("sanity");
          healPer = randBetween(minHealPerSanity, maxHealPerSanity);
          player.add("health", Math.round(sanity * healPer));
          return player.setPhase("healed");
        }
      }, {
        text: "Ignore the first-aid kit",
        icon: "fa-ban",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("stillrunning");
        }
      }
    ]
  },
  healed: {
    text: "You worked hard to heal yourself.",
    choices: [
      {
        text: "Start running",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("stillrunning");
        }
      }
    ]
  },
  stillrunning: {
    text: "You started running.  After a while, it gets randomly ridiculously dark -- apparently whoever it is that decides how fast time moves hates you, or is just lazy.  You are approached by three creatures, one of which looks significantly larger and weirder than any you have seen before.",
    choices: [
      {
        text: "Fight",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          return player.setPhase("foughttwo");
        }
      }, {
        text: "Run",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -5);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  foughttwo: {
    text: "You pull out your dagger as the creatures approach one by one, with the big one conveniently in the back.  You successfully dispatch the first two creatures and turn to face the third.",
    choices: [
      {
        text: "Stand and fight",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(2);
          return player.setPhase("foughtboss");
        }
      }, {
        text: "Turn and run",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -5);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  foughtboss: {
    text: "You exert yourself more than you usually have and take care of the larger creature.  It's night, so you know that you should probably sleep.",
    choices: [
      {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 20);
          player.add("strength", 4);
          player.add("health", 10);
          return player.nextDay();
        }
      }, {
        text: "Don't sleep",
        icon: "fa-thumbs-o-down",
        action: function(player) {
          player.add("sanity", -5);
          player.add("strength", -1);
          return player.nextDay();
        }
      }
    ]
  },
  ranaway: {
    text: "You sprint in the opposite direction as fast as possible.  You do not see anything following you.  It's getting late and you are tired.",
    choices: [
      {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 15);
          player.add("strength", 3);
          player.add("health", 8);
          return player.nextDay();
        }
      }, {
        text: "Don't sleep",
        icon: "fa-thumbs-o-down",
        action: function(player) {
          player.add("sanity", -10);
          player.add("strength", -2);
          return player.nextDay();
        }
      }
    ]
  }
};

content[3] = {
  start: {
    text: "You are impressed with jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj.  You may or may not be going certifiably insane.  I might be the insane one.",
    choices: [
      {
        text: "Who are you?",
        icon: "fa-question",
        action: function(player) {
          return player.setPhase("whoareyou");
        }
      }
    ]
  },
  whoareyou: {
    text: "I'm the developer.  Shouldn't that be obvious?",
    choices: [
      {
        text: "Oh, nice.  You're cool.",
        icon: "fa-check",
        action: function(player) {
          player.add("health", 9000);
          player.add("strength", 9000);
          player.add("sanity", 9000);
          return player.setPhase("ohnice");
        }
      }, {
        text: "You're not a good person.",
        icon: "fa-exclamation",
        action: function(player) {
          return player.setPhase("badperson");
        }
      }, {
        text: "I HATE YOU!",
        icon: "fa-cutlery",
        action: function(player) {
          return player.setPhase("hatersgonnahate");
        }
      }
    ]
  },
  ohnice: {
    text: "It's nice to have some appreciation for once.  Here, feel refreshed.",
    choices: [
      {
        text: "Thanks, but isn't there supposed to be a plot?",
        icon: "fa-question",
        action: function(player) {
          return player.setPhase("wherestheplot");
        }
      }
    ]
  },
  badperson: {
    text: "And you're not a good person either.  Good people are nice to developers.",
    choices: [
      {
        text: "And another thing.  Isn't there supposed to be a plot?",
        icon: "fa-question",
        action: function(player) {
          return player.setPhase("wherestheplot");
        }
      }
    ]
  },
  hatersgonnahate: {
    text: "Oh yeah?  Well, how's this for hatred?  YOU'RE DEAD.",
    choices: [
      {
        text: "Am not.",
        icon: "fa-exclamation",
        action: function(player) {
          return player.setPhase("notdead");
        }
      }
    ]
  },
  notdead: {
    text: "Are too.",
    choices: [
      {
        text: "Am not.",
        icon: "fa-exclamation",
        action: function(player) {
          return player.setPhase("notdead");
        }
      }, {
        text: "Okay, fine, I'm dead.",
        icon: "fa-check",
        action: function(player) {
          return player.setPhase("dead");
        }
      }
    ]
  },
  dead: {
    text: "Of course you are.  I'm the developer!  I should know!",
    choices: [
      {
        text: "Well, if you're so smart, what happened to the plot?",
        icon: "fa-question",
        action: function(player) {
          return player.setPhase("wherestheplot");
        }
      }
    ]
  },
  wherestheplot: {
    text: "You actually noticed there was a plot?  I feel special now.",
    choices: [
      {
        text: "But where did it go?",
        icon: "fa-question",
        action: function(player) {
          return player.setPhase("icanhazplot");
        }
      }, {
        text: "Actually, now that you mention it, \"plot\" is a bit generous.",
        icon: "fa-exclamation",
        action: function(player) {
          return player.setPhase("notaplot");
        }
      }
    ]
  },
  icanhazplot: {
    text: "I guess you can have your precious plot back if you're going to be so picky about it.",
    choices: [
      {
        text: "Thanks.",
        icon: "fa-magic",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  notaplot: {
    text: "Well, if you want something done right, go do it yourself!",
    choices: [
      {
        text: "Okay then, I will.",
        icon: "fa-code-fork",
        action: function(player) {
          return window.location = "https://github.com/mathphreak/LD28-You-Only-Get-One";
        }
      }
    ]
  }
};

content[4] = {
  start: {
    text: "After a bizarre encounter with someone who claimed to be the developer, you decide that you should probably get some sleep.",
    choices: [
      {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 20);
          player.add("strength", 2);
          player.add("health", 5);
          return player.setPhase("wakeup");
        }
      }
    ]
  },
  wakeup: {
    text: "You wake up feeling considerably more relaxed and in the zone.  You abandon all hope that your path makes any sense whatsoever and begin walking, eager to experience whatever on Earth this crazy developer person has in store for you.</p><p>The developer complies with your lack of desire for any semblance of reason and shuns allowing you to do any activity except for running and sleeping.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("s");
        }
      }
    ]
  },
  r: {
    text: "You run for a bit.  You are begnning to see the fortress, as if you still care.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -50);
          player.add("health", -50);
          player.add("sanity", -10);
          return player.setPhase("rr");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 5);
          player.add("strength", 1);
          player.add("health", 2);
          return player.setPhase("rs");
        }
      }
    ]
  },
  rr: {
    text: "You run more.  You're really tired now.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -500);
          player.add("health", -500);
          player.add("sanity", -100);
          return player.setPhase("rr");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 10);
          player.add("strength", 2);
          player.add("health", 5);
          return player.setPhase("rrs");
        }
      }
    ]
  },
  rs: {
    text: "It's a bit early for sleeping, but you still manage to find a comfortable place and sleep.</p><p>You are awoken by a loud sound.  The sky is mostly dark, but you can tell it's just before sunrise.  The five creatures don't care.  They're attacking you anyways.",
    choices: [
      {
        text: "Fight",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          return player.setPhase("rsf");
        }
      }, {
        text: "Run",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -5);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  rsf: {
    text: "You kill three of the creatures, and the other two run off.  One of the creatures that you killed conveniently dropped a first-aid kit, though God only knows why these things would be carrying first-aid kits.  You're hardly in a position to complain, though.",
    choices: [
      {
        text: "Use the first-aid kit",
        icon: "fa-medkit",
        action: function(player) {
          var healPer, sanity;
          sanity = player.get("sanity");
          healPer = randBetween(minHealPerSanity, maxHealPerSanity);
          player.add("health", Math.round(sanity * healPer));
          return player.setPhase("healed");
        }
      }, {
        text: "Ignore the first-aid kit",
        icon: "fa-ban",
        action: function(player) {
          return player.setPhase("rrs");
        }
      }
    ]
  },
  ranaway: {
    text: "You run as fast as you can.  You don't see anything following you.  You fall asleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  healed: {
    text: "You patch yourself up a bit.  You cave in and sleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  rrs: {
    text: "You cave in and sleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  s: {
    text: "It's daytime.  You can't fall asleep.  No matter how hard you try.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("strength", -10);
          return player.setPhase("ss");
        }
      }
    ]
  },
  ss: {
    text: "Still daytime.  You try so hard to fall asleep that you pull a muscle.  Somehow.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", -1000);
          return player.setPhase("ss");
        }
      }
    ]
  }
};

content[5] = {
  start: {
    text: "You wake up refreshed and relaxed, almost as if you're most of the way to your destination you never cared about in the first place.  You know the drill.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("s");
        }
      }
    ]
  },
  r: {
    text: "You run for a bit.  You can see the banners waving from the fortress, as if you still care.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -50);
          player.add("health", -50);
          player.add("sanity", -10);
          return player.setPhase("rr");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 5);
          player.add("strength", 1);
          player.add("health", 2);
          return player.setPhase("rs");
        }
      }
    ]
  },
  rr: {
    text: "You run more.  You're really tired now.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -500);
          player.add("health", -500);
          player.add("sanity", -100);
          return player.setPhase("rr");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", 10);
          player.add("strength", 2);
          player.add("health", 5);
          return player.setPhase("rrs");
        }
      }
    ]
  },
  rs: {
    text: "It's a bit early for sleeping, but you still manage to find a comfortable place and sleep.</p><p>You are awoken by a loud sound.  The sky is mostly dark, but you can tell it's just before sunrise.  The five creatures don't care.  They're attacking you anyways.",
    choices: [
      {
        text: "Fight",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          player.takeDamageFromEnemyWithDifficulty(1);
          return player.setPhase("rsf");
        }
      }, {
        text: "Run",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -5);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  rsf: {
    text: "You kill three of the creatures, and the other two run off.  One of the creatures that you killed conveniently dropped a first-aid kit, though God only knows why these things would be carrying first-aid kits.  You're hardly in a position to complain, though.",
    choices: [
      {
        text: "Use the first-aid kit",
        icon: "fa-medkit",
        action: function(player) {
          var healPer, sanity;
          sanity = player.get("sanity");
          healPer = randBetween(minHealPerSanity, maxHealPerSanity);
          player.add("health", Math.round(sanity * healPer));
          return player.setPhase("healed");
        }
      }, {
        text: "Ignore the first-aid kit",
        icon: "fa-ban",
        action: function(player) {
          return player.setPhase("rrs");
        }
      }
    ]
  },
  ranaway: {
    text: "You run as fast as you can.  You don't see anything following you.  You fall asleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  healed: {
    text: "You patch yourself up a bit.  You cave in and sleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  rrs: {
    text: "You cave in and sleep.",
    choices: [
      {
        text: "Wake up",
        icon: "fa-hand-o-up",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  },
  s: {
    text: "It's daytime.  You can't fall asleep.  No matter how hard you try.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("strength", -10);
          return player.setPhase("ss");
        }
      }
    ]
  },
  ss: {
    text: "Still daytime.  You try so hard to fall asleep that you pull a muscle.  Somehow.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          player.add("sanity", -1000);
          return player.setPhase("ss");
        }
      }
    ]
  }
};

content[6] = {
  start: {
    text: "You can tell that you're almost there.  You can read the title on the fortress.  Which isn't even relevant, as you no longer care about anything except being done with the game so you can give me my 0.0 on every single category, since the theme wasn't \"You Only Can Make Crappy Games!\"",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("s");
        }
      }
    ]
  },
  s: {
    text: "Seriously, you're stupid.  Go die (in the game, I mean).",
    choices: [
      {
        text: "Okay, fine",
        icon: "fa-bolt",
        action: function(player) {
          player.add("health", -1000);
          return player.setPhase("s");
        }
      }, {
        text: "No",
        icon: "fa-paperclip",
        action: function(player) {
          return player.setPhase("resisting");
        }
      }
    ]
  },
  resisting: {
    text: "Okay, fine then, if you want to survive then don't try to sleep during the day.",
    choices: [
      {
        text: "Run",
        icon: "fa-road",
        action: function(player) {
          player.add("strength", -10);
          player.add("health", -5);
          player.add("sanity", -2);
          return player.setPhase("r");
        }
      }, {
        text: "Sleep",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("f7u12");
        }
      }
    ]
  },
  f7u12: {
    text: "That's not okay.",
    choices: [
      {
        text: "Is too",
        icon: "fa-fire",
        action: function(player) {
          return player.setPhase("f7u12");
        }
      }, {
        text: "No, you're right, it isn't.",
        icon: "fa-check",
        action: function(player) {
          return player.setPhase("resisting");
        }
      }
    ]
  },
  r: {
    text: "You walk up to the gates of the fortress and search for a doorbell or something to alert them to your presence.  You're checking for secret buttons when the guards ask you why you're there.",
    choices: [
      {
        text: "I live here",
        icon: "fa-home",
        action: function(player) {
          return player.setPhase("compliant");
        }
      }, {
        text: "The town leaders said to meet here",
        icon: "fa-users",
        action: function(player) {
          return player.setPhase("smart");
        }
      }, {
        text: "I am in need of shelter from these creatures",
        icon: "fa-shield",
        action: function(player) {
          return player.setPhase("compliant");
        }
      }
    ]
  },
  smart: {
    text: "The guards are impressed that you remembered the plot.  They open the gates.",
    choices: [
      {
        text: "Go inside",
        icon: "fa-sign-in",
        action: function(player) {
          return player.setPhase("inside");
        }
      }, {
        text: "Stay outside",
        icon: "fa-sign-out",
        action: function(player) {
          return player.setPhase("stupid");
        }
      }
    ]
  },
  compliant: {
    text: "The two guards call you out on your crap.  They know as well as I do that the plot made no sense and was instantly forgettable, but unlike me, they don't care.  They run towards you.",
    choices: [
      {
        text: "Fight",
        icon: "fa-cutlery",
        action: function(player) {
          player.takeDamageFromEnemyWithDifficulty(2.5);
          player.takeDamageFromEnemyWithDifficulty(2.5);
          return player.setPhase("ggn00b");
        }
      }, {
        text: "Run",
        icon: "fa-rocket",
        action: function(player) {
          player.add("strength", -5);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  ggn00b: {
    text: "You valiantly and honorably kill the two guards who figured out you were lying to them, but you're stuck outside the gates.  Forever.",
    choices: [
      {
        text: "Try to open the gates",
        icon: "fa-sort",
        action: function(player) {
          if (player.get("strength") > 60) {
            player.add("strength", -40);
            return player.setPhase("brokein");
          } else {
            player.add("health", -1000000);
            return player.setPhase("ggn00b");
          }
        }
      }
    ]
  },
  ranaway: {
    text: "The guards take your departure as an admission of guilt and kill you.  Instantly.",
    choices: [
      {
        text: "Okay?",
        icon: "fa-thumbs-up",
        action: function(player) {
          player.add("health", -10000000);
          return player.setPhase("ranaway");
        }
      }
    ]
  },
  brokein: {
    text: "It took a lot of muscle, but you successfully broke open the gates.",
    choices: [
      {
        text: "Go inside",
        icon: "fa-sign-in",
        action: function(player) {
          return player.setPhase("inside");
        }
      }, {
        text: "Stay outside",
        icon: "fa-sign-out",
        action: function(player) {
          return player.setPhase("stupid");
        }
      }
    ]
  },
  stupid: {
    text: "That's stupid.",
    choices: [
      {
        text: "Go inside",
        icon: "fa-sign-in",
        action: function(player) {
          return player.setPhase("inside");
        }
      }, {
        text: "Stay outside",
        icon: "fa-sign-out",
        action: function(player) {
          return player.setPhase("stupid");
        }
      }
    ]
  },
  inside: {
    text: "Inside the fortress, you find a whole bunch of people who you recognize from your town.  Friends, family, bitter enemies, the whole deal.  In fact, you can't think of anyone who isn't there.  Congratulations, you win!",
    choices: [
      {
        text: "Accept your victory",
        icon: "fa-trophy",
        action: function(player) {
          return player.nextDay();
        }
      }
    ]
  }
};

content[7] = {
  start: {
    text: "Now that you've \"won\" and accepted your victory, you have several options.",
    choices: [
      {
        text: "Restart",
        icon: "fa-refresh",
        action: function(player) {
          return restart();
        }
      }, {
        text: "Quit",
        icon: "fa-power-off",
        action: function(player) {
          return location.href = "https://www.youtube.com/embed/oavMtUWDBTM?autoplay=1";
        }
      }
    ]
  }
};

/*

You have three statistics: health, strength, and sanity.  All of them are tracked by the game, but only one of them is
visible; you only get one that you can see.
*/

window.restart = function() {};

$(function() {
  var Choice, ChoiceView, GameAction, GameIntro, Player, StatChooser, Statistic, action, chooser, currentPlayer, intro, lost, stat;
  lost = false;
  Choice = Backbone.Model.extend({});
  ChoiceView = Backbone.View.extend({
    tagName: "li",
    template: _.template($("#choice-template").html()),
    events: {
      "click button": "execute"
    },
    render: function() {
      return this.$el.html(this.template(this.model.attributes));
    },
    execute: function() {
      return this.model.get("action")(currentPlayer);
    }
  });
  Player = Backbone.Model.extend({
    takeDamageFromEnemyWithDifficulty: function(enemyDifficulty) {
      var damage, insanity, _ref;
      _ref = getCombatBasedOnStrength(this.get("strength"), enemyDifficulty), damage = _ref.damage, insanity = _ref.insanity;
      this.add("health", -damage);
      return this.add("sanity", -insanity);
    },
    setPhase: function(phase) {
      return this.set({
        phase: phase
      });
    },
    nextDay: function() {
      return this.set({
        day: this.get("day") + 1,
        phase: "start"
      });
    },
    maxSelected: function() {
      switch (this.get("selectedStat")) {
        case "health":
          return this.get("maxHealth");
        case "strength":
          return this.get("maxStrength");
        case "sanity":
          return this.get("maxSanity");
        default:
          return console.error("AAAAAAAAAAAAAAAAAAAAAAA");
      }
    },
    currentSelected: function() {
      switch (this.get("selectedStat")) {
        case "health":
          return this.get("health");
        case "strength":
          return this.get("strength");
        case "sanity":
          return this.get("sanity");
        default:
          return console.error("AAAAAAAAAAAAAAAAAAAAAAA");
      }
    },
    add: function(attr, modifier) {
      var modification;
      modification = {};
      modification[attr] = this.get(attr) + modifier;
      return this.set(modification);
    },
    defaults: function() {
      var maxHealth, maxSanity, maxStrength;
      maxHealth = randIntBetween(minInitialHealth, maxInitialHealth);
      maxStrength = randIntBetween(minInitialStrength, maxInitialStrength);
      maxSanity = randIntBetween(minInitialSanity, maxInitialSanity);
      return {
        maxHealth: maxHealth,
        maxStrength: maxStrength,
        maxSanity: maxSanity,
        health: maxHealth,
        strength: maxStrength,
        sanity: maxSanity,
        selectedStat: "",
        gameStarted: false,
        day: 0,
        phase: "start",
        lost: false
      };
    }
  });
  currentPlayer = new Player;
  window.restart = function() {
    return setTimeout(function() {
      return currentPlayer.set(new Player().attributes);
    }, 0);
  };
  currentPlayer.on("change:health", function() {
    if (currentPlayer.get("health") < 0) {
      if (!lost) {
        alert("You died.");
        lost = true;
        restart();
      }
    }
    if (currentPlayer.get("health") > currentPlayer.get("maxHealth")) {
      return currentPlayer.set({
        health: currentPlayer.get("maxHealth")
      });
    }
  });
  currentPlayer.on("change:strength", function() {
    if (currentPlayer.get("strength") < 0) {
      currentPlayer.set({
        strength: 0
      });
    }
    if (currentPlayer.get("strength") > currentPlayer.get("maxStrength")) {
      return currentPlayer.set({
        strength: currentPlayer.get("maxStrength")
      });
    }
  });
  currentPlayer.on("change:sanity", function() {
    if (currentPlayer.get("sanity") < 0) {
      if (!lost) {
        alert("You went insane.");
        lost = true;
        setTimeout(function() {
          return currentPlayer.set(new Player().attributes);
        }, 0);
      }
    }
    if (currentPlayer.get("sanity") > currentPlayer.get("maxSanity")) {
      return currentPlayer.set({
        sanity: currentPlayer.get("maxSanity")
      });
    }
  });
  Statistic = Backbone.View.extend({
    el: $("#statistic"),
    template: _.template($("#statistic").html()),
    initialize: function() {
      return this.listenTo(this.model, "change", this.render);
    },
    render: function() {
      if (this.model.get("selectedStat") !== "") {
        this.$el.show();
        return this.$el.html(this.template({
          selected: this.model.get("selectedStat"),
          current: this.model.currentSelected(),
          maximum: this.model.maxSelected(),
          health: leetHax0rMode ? this.model.get("health") : 0,
          strength: leetHax0rMode ? this.model.get("strength") : 0,
          sanity: leetHax0rMode ? this.model.get("sanity") : 0,
          extraClass: getStatBarClass(this.model.currentSelected())
        }));
      } else {
        return this.$el.hide();
      }
    }
  });
  StatChooser = Backbone.View.extend({
    el: $("#stat-chooser"),
    events: {
      "click .health": "health",
      "click .strength": "strength",
      "click .sanity": "sanity"
    },
    initialize: function() {
      return this.listenTo(this.model, "change", this.render);
    },
    render: function() {
      if (this.model.get("selectedStat") === "" && this.model.get("gameStarted")) {
        return this.$el.show();
      } else {
        return this.$el.hide();
      }
    },
    health: function() {
      return this.model.set({
        selectedStat: "health"
      });
    },
    strength: function() {
      return this.model.set({
        selectedStat: "strength"
      });
    },
    sanity: function() {
      return this.model.set({
        selectedStat: "sanity"
      });
    }
  });
  GameIntro = Backbone.View.extend({
    el: $("#game-intro"),
    events: {
      "click #start-game": "begin"
    },
    initialize: function() {
      return this.listenTo(this.model, "change", this.render);
    },
    render: function() {
      if (this.model.get("gameStarted")) {
        return this.$el.hide();
      } else {
        return this.$el.show();
      }
    },
    begin: function() {
      return this.model.set({
        gameStarted: true
      });
    }
  });
  GameAction = Backbone.View.extend({
    el: $("#game-action"),
    template: _.template($("#game-action").html()),
    initialize: function() {
      return this.listenTo(this.model, "change", this.render);
    },
    render: function() {
      var choice, currentContent, view, _i, _len, _ref;
      currentContent = getContentFor(this.model.get("day"), this.model.get("phase"));
      this.$el.html(this.template({
        bodytext: currentContent.text
      }));
      _ref = currentContent.choices;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        choice = _ref[_i];
        view = new ChoiceView({
          model: new Choice(choice)
        });
        view.render();
        this.$("#choices").append(view.el);
      }
      if (this.model.get("selectedStat") !== "") {
        return this.$el.show();
      } else {
        return this.$el.hide();
      }
    }
  });
  stat = new Statistic({
    model: currentPlayer
  });
  stat.render();
  chooser = new StatChooser({
    model: currentPlayer
  });
  chooser.render();
  intro = new GameIntro({
    model: currentPlayer
  });
  intro.render();
  action = new GameAction({
    model: currentPlayer
  });
  return action.render();
});
