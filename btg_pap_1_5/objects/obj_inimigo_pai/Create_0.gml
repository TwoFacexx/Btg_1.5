// Herda o comportamento do pai
// Inherits from parent
event_inherited();

// Estados de dano e morte
// Damage and death states
dano = false;
morto = false;

// Função para mudar de sprite e reiniciar a animação
// Function to change sprite and restart animation
muda_sprite = function(_sprite)
{
    if (sprite_index != _sprite)
    {
        sprite_index = _sprite;
        image_index = 0;
    }
}
