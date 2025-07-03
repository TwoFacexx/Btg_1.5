// Fazendo a colisão horizontal
// Doing horizontal collision

// Checando se eu estou colidindo com a parede
// Checking if I am colliding with a wall
var _col = instance_place(x + velh, y, obj_chao);

// Se eu colidi eu grudo em quem eu colidi
// If I collided, I stick to the object I collided with
if (_col)
{
    // Checando se eu estou indo para a direita
    // Checking if I am moving right
    if (velh > 0)
    {
        // Grudando na parte esquerda da parede
        // Sticking to the left side of the wall
        x = _col.bbox_left + (x - bbox_right);
    }
    
    // Checando se eu estou indo para a esquerda
    // Checking if I am moving left
    if (velh < 0)
    {
        // Grudando na parte direita da parede
        // Sticking to the right side of the wall
        x = _col.bbox_right + (x - bbox_left);
    }
    
    // Uma vez que eu colidi, não importa o lado, eu paro
    // Once I collided, no matter the side, I stop
    velh = 0;
}

// Atualiza a posição horizontal com o valor da velocidade
// Update horizontal position with velocity value
x += velh;

// Fazendo a colisão vertical
// Doing vertical collision

// Checando se estou colidindo no chão ou teto
// Checking if colliding with ground or ceiling
var _col = instance_place(x, y + velv, obj_chao);

if (_col)
{
    // Se estou indo para baixo
    // If moving down
    if (velv > 0)
    {
        // Grudo no topo da plataforma/chão
        // Stick to top of platform/ground
        y = _col.bbox_top + (y - bbox_bottom);
    }
    
    // Se estou indo para cima
    // If moving up
    if (velv < 0)
    {
        // Grudo na parte inferior do teto/plataforma
        // Stick to bottom of ceiling/platform
        y = _col.bbox_bottom + (y - bbox_top);
    }
    
    // Paro o movimento vertical pois colidi com algo
    // Stop vertical movement because I collided with something
    velv = 0;
}

// Atualiza a posição vertical com o valor da velocidade
// Update vertical position with velocity value
y += velv;