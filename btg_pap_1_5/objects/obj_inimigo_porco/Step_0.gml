// Step Event - obj_inimigo_porco

// Se morreu, executa a lógica de morte e sai
if (morto) 
{
    // Contar morte apenas uma vez
    if (!ja_contou_morte) 
    {	
        ja_contou_morte = true;
        
        global.porcos_mortos_total++;
        global.porcos_sessao++;
        save_update_stat("porcos_mortos", 1);
        
        show_debug_message("Porcos mortos agora: " + string(global.porcos_mortos_total));
       
		
        if (global.porcos_mortos_total == 1) {
		 show_debug_message("Tentando salvar conquista primeiro_porco");	
            if (save_add_achievement("primeiro_porco")) {
                mostrar_conquista("Primeiro Bacon!");
            }
        }
        if (global.porcos_mortos_total == 10) {
            if (save_add_achievement("10_porcos")) {
                mostrar_conquista("Caçador de Porcos!");
            }
        }
    }
    
    sprite_index = spr_inimigo_porco_dead;
    
    //Sumindo se acabou a minha animação
    if (image_speed <= 0)
    {
        image_alpha -= 0.01;
    }
    //Se eu sumi totalmente, eu me destruo
    if (image_alpha <= 0)
    {
        instance_destroy();
    }
    
    exit; // Sair - não executar resto do código
}

//Checando se o porco esta no chão
var _chao = place_meeting(x, y + 1, obj_chao);

if (estado == "normal")
{
    //Checando se eu colidi com uma bomba
    var _bomba = instance_place(x, y, obj_bomba);
    
    if (_bomba && _chao)
    {
        //Se eu não vou pegar a bomba, eu vou ativar ela
        if (pega_bomba == false)
        {
            //checando se ela ta apagada
            if (_bomba.momento == "off")
            {
                estado = "fosforo_on";
            }
        }
        else if (_bomba.momento == "off")
        {
            //Eu vou pegar a bomba então mano!
            instance_destroy(_bomba);
            //Eu vou virar o porco pegando a bomba
            var _novo_porco = instance_create_layer(x, y, layer, obj_inimigo_porco_bomba);
            _novo_porco.estado = "pega";
            instance_destroy();
        }
    }
    
    if (_chao)
    {
        //Vou diminuir o tempo de decidir andar
        tempo_decidir_andar -= 1;
    
        //Se o tempo acabou, eu decido se eu vou andar
        if (tempo_decidir_andar <= 0)
        {
            andando = choose(true, false);
            
            //Escolhendo a direção se ele decidiu andar
            if (andando)
            {
                velh = choose(vel, -vel);
            }
            else
            {
                velh = 0;	
            }
        
            //Resetando o tempo
            tempo_decidir_andar = room_speed * 3;
        }
    
        //Controlando a animação do inimigo
        if (velh != 0 && dano == false)
        {
            sprite_index = spr_inimigo_porco_run;
            image_xscale = sign(velh);
        }
        else
        {
            sprite_index = spr_inimigo_porco_idle;
        }
    
        //Se eu bater na parede, eu mudo de direção
        if (place_meeting(x + velh, y, obj_chao))
        {
            velh *= -1;
        }
    
        //Se eu não posso cair, então quando eu for cair eu mudo de direção
        if (pode_cair == false)
        {
            if (place_meeting(x + (velh * 10), y + 1, obj_chao) == false)
            {
                //Se eu não posso cair e não estou tocando no chão na minha frente
                //então eu mudo de direção
                velh *= -1;
            }
        }
    }
    else
    {	
        //Se eu não estou no chão, eu aplico a gravidade
        velv += grav;
    
        if (velh != 0)
        {
            image_xscale = sign(velh);
        }
    }
}
//Checando se eu estou tomando dano
else if (estado == "fosforo_on")
{
    //Mudando a sprite dele
    if (sprite_index != spr_porco_fosforo_on)
    {
        sprite_index = spr_porco_fosforo_on;
        image_index = 0;
    }
    velh = 0;
    
    //Depois que ele acendeu o fosforo ele muda de estado
    if (image_index >= image_number - 1)
    {
        estado = "fosforo_bomba";
    }
}
else if (estado == "fosforo_bomba")
{
    if (sprite_index != spr_porco_fosforo_bomba)
    {
        sprite_index = spr_porco_fosforo_bomba;
        image_index = 0;
    }
    
    //Terminou a animação
    if (image_index >= image_number - 1)
    {
        var _bomba = instance_place(x, y, obj_bomba);
        if (_bomba)
        {
            _bomba.momento = "on";
            
            //Deixando ele escolher se ele pega a bomba ou se ativa a bomba
            pega_bomba = choose(true, false);
        }
        estado = "normal";
        
        var _canhao = instance_place(x, y, obj_canhao);
        if (_canhao)
        {
            _canhao.estado = "on";
        }
    }
}

if (dano && morto == false)
{
    sprite_index = spr_inimigo_porco_dano;
    velh = 0;
}