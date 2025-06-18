// obj_inimigo_porco_bomba - Create Event:

// ADICIONAR ESTA LINHA NO INÍCIO!
event_inherited(); // Isso vai executar o Create do obj_inimigo_pai

// Resto do código existente...
visao  = 100;
estado = "idle"; //idle, run, pega, joga
vel = 1;
tempo_estado = room_speed * 1;
timer_estado = tempo_estado;
tomei_dano	 = false;

ver_o_player = function()
{
    var _vi_player = collision_line(x, y - 14, x + visao * image_xscale, y - 14, obj_player, false, true);
    
    if (_vi_player)
    {
        estado = "joga";
    }
}