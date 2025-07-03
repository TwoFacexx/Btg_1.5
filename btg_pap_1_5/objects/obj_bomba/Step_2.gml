// Se o estado for "boom", sai do evento sem executar o código herdado
// If the state is "boom", exit the event without running inherited code
if (momento == "boom")
{
    exit;
}

// Herdar o evento final do objeto pai (geralmente trata colisões)
// Inherit the final step event from the parent object (usually handles collisions)
event_inherited();
