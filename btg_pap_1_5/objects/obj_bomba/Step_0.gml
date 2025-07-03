// Aplicar gravidade à velocidade vertical
// Apply gravity to vertical speed
velv += grav;

// Verificar se a bomba está no chão
// Check if the bomb is on the ground
if (place_meeting(x, y + 1, obj_chao))
{
	// Se estiver a mover-se horizontalmente, aplicar atrito
	// If moving horizontally, apply friction
	if (velh != 0)
	{
		velh *= .92;
	}
}
else
{
	// Se estiver no ar, aplicar desaceleração mais leve
	// If in the air, apply lighter deceleration
	velh *= .995;
}

// Verificar se o estado da bomba é "off"
// Check if bomb state is "off"
if (momento == "off")
{
	// Sprite da bomba desligada
	// Bomb's inactive sprite
	sprite_index = spr_bomba;
}
else if (momento == "on")
{
	// Sprite da bomba ligada (com luz ou contagem)
	// Bomb's active sprite (with light or countdown)
	sprite_index = spr_bomba_on;
	
	// Contagem decrescente para explodir
	// Countdown timer for explosion
	if (boom_timer > 0)
	{
		boom_timer--;
	}
	else
	{
		// Quando o tempo acabar, mudar o estado para "boom"
		// When timer ends, switch state to "boom"
		momento = "boom";
	}
}
else if (momento == "boom")
{
	// Código da explosão
	// Explosion code
	
	// Verificar se ainda não mudou o sprite para o de explosão
	// Check if it hasn't changed to the explosion sprite yet
	if (sprite_index != spr_bomba_boom)
	{
		// Primeira vez no estado "boom", mudar sprite
		// First time in "boom" state, change sprite
		sprite_index = spr_bomba_boom;
		// Reiniciar a animação
		// Restart animation
		image_index = 0;
		
		// Tocar som da bomba
		// Play bomb sound
		tocar_som(som_bomba, 10, false);
		
		// Criar partículas de explosão
		// Create explosion particles
	    criar_particulas_explosao(x, y);
	    // Agitar o ecrã
	    // Shake the screen
	    screenshake(5);
	}
	
	// Se a animação terminar, destruir a instância
	// If the animation finishes, destroy the instance
	if (image_index >= image_number-1)
	{
		instance_destroy();
	}
	
	// Verificar colisão com o jogador
	// Check collision with player
	var _player = instance_place(x, y, obj_player);
	if (_player)
	{
	    with(_player)
	    {
	    	// Aplicar dano ao jogador
	    	// Apply damage to the player
	        dano = true;
	        timer_dano  = tempo_dano;
	        inv_timer	= inv_tempo;
	    }
	    
	    // Tentar registar a conquista "explosivo"
	    // Try to register the "explosivo" achievement
	    if (save_add_achievement("explosivo")) {
			show_debug_message("Tentando salvar conquista explosivo");
	        mostrar_conquista("Explosivo!");
	    }
	}
	
	// Verificar se há outra bomba no mesmo local
	// Check if another bomb is in the same place
	var _bomba = instance_place(x, y, obj_bomba);
	if (_bomba)
	{
		// Se a outra bomba estiver desligada, ativá-la
		// If the other bomb is off, activate it
		if (_bomba.momento == "off")
		{
			_bomba.boom_timer = room_speed;
			_bomba.momento = "on";
		}
	}
}
