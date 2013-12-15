content = []

_.templateSettings =
  interpolate : /\{\{(.+?)\}\}/g

leetHax0rMode = off

minInitialHealth = 90
maxInitialHealth = 110
minInitialStrength = 90
maxInitialStrength = 110
minInitialSanity = 90
maxInitialSanity = 110
minEnemyHealthPerDifficulty = 20
maxEnemyHealthPerDifficulty = 30
minDamageFactor = 0.4
maxDamageFactor = 0.6
minEnemyStrengthPerDifficulty = 20
maxEnemyStrengthPerDifficulty = 30
minHealPerSanity = 0.3
maxHealPerSanity = 0.5

randBetween = (min, max) -> Math.random() * (max - min) + min

randIntBetween = (min, max) -> Math.round(randBetween(min, max))

getStatBarClass = (value) ->
    if value > 90
        "progress-bar-success"
    else if value > 70
        "progress-bar-info"
    else if value > 50
        ""
    else if value > 25
        "progress-bar-warning"
    else
        "progress-bar-danger"

getContentFor = (day, phase) ->
    currentDay = content[day]
    currentPhase = currentDay[phase]
    return currentPhase

getCombatBasedOnStrength = (strength, enemyDifficulty) ->
    enemyHealth = enemyDifficulty * randIntBetween(minEnemyHealthPerDifficulty, maxEnemyHealthPerDifficulty)
    enemyStrength = enemyDifficulty * randIntBetween(minEnemyStrengthPerDifficulty, maxEnemyStrengthPerDifficulty)
    damage = strength * randBetween(minDamageFactor, maxDamageFactor)
    enemyDamage = enemyStrength * randBetween(minDamageFactor, maxDamageFactor)
    numberOfStrikes = enemyHealth / damage
    return {
        damage: Math.round(numberOfStrikes * enemyDamage)
        insanity: Math.round(numberOfStrikes)
    }
