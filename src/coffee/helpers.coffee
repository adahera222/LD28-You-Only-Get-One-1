content = []

_.templateSettings =
  interpolate : /\{\{(.+?)\}\}/g

# TODO DISABLE
leetHax0rMode = on

# TODO CHANGE THESE
minInitialHealth = 100
maxInitialHealth = 100
minInitialStrength = 100
maxInitialStrength = 100
minInitialSanity = 100
maxInitialSanity = 100
minEnemyHealthPerDifficulty = 25
maxEnemyHealthPerDifficulty = 25
minDamageFactor = 0.5
maxDamageFactor = 0.5
minEnemyStrengthPerDifficulty = 25
maxEnemyStrengthPerDifficulty = 25

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

getDamageTakenBasedOnStrength = (strength, enemyDifficulty) ->
    enemyHealth = enemyDifficulty * randIntBetween(minEnemyHealthPerDifficulty, maxEnemyHealthPerDifficulty)
    enemyStrength = enemyDifficulty * randIntBetween(minEnemyStrengthPerDifficulty, maxEnemyStrengthPerDifficulty)
    damage = strength * randBetween(minDamageFactor, maxDamageFactor)
    enemyDamage = enemyStrength * randBetween(minDamageFactor, maxDamageFactor)
    numberOfStrikes = enemyHealth / damage
    return numberOfStrikes * enemyDamage
