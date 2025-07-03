velv += grav;
// Aplicar gravidade à velocidade vertical
// Apply gravity to vertical velocity

// Se ainda não levei dano e agora levei, mudo o estado para 'hit'
// If I haven't taken damage yet and now I did, change state to 'hit'
if (dano && !tomei_dano)
{
    estado = "hit"; // Estado de dano
    tomei_dano = true; // Marcar que já levou dano
}

switch(estado)
{
    case "idle":
        muda_sprite(spr_porco_bomba_idle); 
        // Muda a sprite para parado / Change sprite to idle
        
        velh = 0; 
        // Parado, sem velocidade horizontal / Stopped, no horizontal speed
        
        ver_o_player(); 
        // Ver se o jogador está na visão / Check if player is visible
        
        timer_estado--; 
        // Diminuir o tempo do estado atual / Decrease current state timer
        
        if (timer_estado <= 0)
        {
            estado = choose("run", "idle"); 
            // Aleatoriamente escolhe correr ou ficar parado / Randomly choose to run or idle
            timer_estado = tempo_estado; 
            // Resetar o timer do estado / Reset state timer
            
            if (estado == "run")
            {
                velh = choose(-vel, vel); 
                // Se for correr, escolher direção (esquerda ou direita) / If running, choose direction (left or right)
            }
        }
        
    break;
    
    case "run":
        ver_o_player(); 
        // Ver o jogador novamente / Check player again
        
        muda_sprite(spr_porco_bomba_run); 
        // Muda para sprite de correr / Change to run sprite
        
        if (velh != 0)
        {
            image_xscale = sign(velh); 
            // Olhar para a direção que está a andar / Face the walking direction
        }
        
        if (place_meeting(x + velh, y, obj_chao))
        {
            velh *= -1; 
            // Se bater na parede, muda de direção / If hit wall, reverse direction
        }
        
        timer_estado--; 
        // Contagem decrescente do tempo do estado / Countdown state timer
        
        if (timer_estado <= 0)
        {
            estado = choose("run", "idle"); 
            // Escolhe novo estado / Choose new state
            timer_estado = tempo_estado; 
            // Resetar o timer / Reset timer
        }
        
    break;
    
    case "joga":
        muda_sprite(spr_porco_bomba_joga); 
        // Sprite de lançar bomba / Bomb throwing sprite
        
        velh = 0; 
        // Fica parado ao lançar / Stop when throwing
        
        if (image_index >= image_number - 1)
        {
            // Quando a animação termina, cria bomba / When animation ends, create bomb
            var _bomba = instance_create_layer(x, y - 14, "projeteis", obj_bomba);
            _bomba.velh = 3 * image_xscale; 
            _bomba.velv = -3;
            _bomba.momento = "on"; 
            // Define que a bomba está ativada / Set bomb to active
            
            var _novo_porco = instance_create_layer(x, y, layer, obj_inimigo_porco);
            _novo_porco.estado = "normal"; 
            _novo_porco.pega_bomba = false; 
            _novo_porco.velh = 0; 
            instance_destroy(); 
            // Destroi este porco, substitui pelo normal / Destroy this pig, replace with normal pig
        }
        
    break;
    
    case "pega":
        muda_sprite(spr_porco_bomba_pega); 
        // Sprite de pegar bomba / Grab bomb sprite
        
        velh = 0; 
        // Fica parado ao pegar / Stay still when grabbing
        
        if (image_index >= image_number - 1)
        {
            estado = "idle"; 
            // Quando termina a animação, volta ao estado parado / Return to idle after animation
        }
    break;
    
    case "hit":
        muda_sprite(spr_inimigo_porco_dano); 
        // Sprite de dano / Damage sprite
        
        if (image_index >= image_number - 1)
        {
            estado = "dead"; 
            // Quando termina a animação de dano, morre / When damage animation ends, dies
        }
    break;
    
    case "dead":
        morto = true; 
        // Marca como morto / Mark as dead
        
        if (morto && !ja_contou_morte) 
        {   
            ja_contou_morte = true; 
            // Conta a morte só uma vez / Count death only once
            
            global.porcos_mortos_total++;
            global.porcos_sessao++;
            save_update_stat("porcos_mortos", 1);
            
            show_debug_message("Porcos mortos agora: " + string(global.porcos_mortos_total));
            // Debug para mostrar o total de porcos mortos / Debug to show total pigs killed
            
            // Verificar conquistas / Check achievements
            if (global.porcos_mortos_total == 1) {
                if (save_add_achievement("primeiro_porco")) {
                    mostrar_conquista("Primeiro Bacon!");
                    // Primeira morte de porco / First pig kill achievement
                }
            }
            if (global.porcos_mortos_total == 10) {
                if (save_add_achievement("10_porcos")) {
                    mostrar_conquista("Caçador de Porcos");
                    // Dez porcos mortos / Ten pigs killed achievement
                }
            }
        }
        
        muda_sprite(spr_inimigo_porco_dead); 
        // Sprite de porco morto / Dead pig sprite
        
        if (image_index >= image_number - 1)
        {
            instance_destroy(); 
            // Destroi o inimigo ao terminar a animação / Destroy enemy after animation ends
        }
    break;
}
