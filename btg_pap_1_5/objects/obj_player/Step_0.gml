//controlando o player
var _chao = place_meeting(x, y + 1, obj_chao);






switch(estado)
{
	
	case "normal":
		estado_normal();
	break;
	
	case "in":

		
		//Terminou a animação, para a animação
		var _img_vel = sprite_get_speed(sprite_index) / room_speed;
		//Indo para o estado normal
		if (image_index > image_number - _img_vel)
		{
			image_speed = 0;
			image_index = image_number - 1;
			image_alpha = 0;
		}
		
	break;
	
	case "out":
		mudando_sprite(spr_player_out);
		
		
		
		var _img_vel = sprite_get_speed(sprite_index) / room_speed;
		//Indo para o estado normal
		if (image_index > image_number - _img_vel)
		{
			estado = "normal";
		}
		
	break;
	
	case "dead":
	
		if(instance_exists(obj_game_control))
		{
			with(obj_game_control)
			{
				game_over = true;
			}
		}
	
		mudando_sprite(spr_player_dead);
		
		timer_reinicia--;
		
		if (timer_reinicia <= 0)
		{
			global.vida = global.max_vida;
			if(keyboard_check(vk_enter)) game_restart();		
		}
		
		//Ficando visivel
		if (image_alpha < 1)
		{
			image_alpha += 0.01;
		}
		if (image_index > image_number - 1)
		{
			image_speed = 0;
			image_index = image_number - 1;
		}
	break;
	
}
