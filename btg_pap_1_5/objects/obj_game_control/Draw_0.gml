if(game_over)
{
	contador = lerp(contador, 1, .01);
	draw_set_alpha(contador);
	var x1 = camera_get_view_x(view_camera[0]);
	var w = camera_get_view_width(view_camera[0]);
	var x2 = x1+w;
	var meio_w = x1+w/2;
	var y1=camera_get_view_y(view_camera[0]);
	var h = camera_get_view_height(view_camera[0]);
	var y2 = y1+h;
	var meio_h = y1+h/2;
	
	var quant = h*.15;
	
	valor = lerp(valor,1, .1)
	
	draw_set_color(c_black);
	draw_set_alpha(valor - .3);
	
	draw_rectangle(x1,y1,x2,y2,false);
	
	draw_rectangle(x1,y1,x2,y1+quant*valor,false);
	
	draw_rectangle(x1,y2,x2,y2-quant*valor,false);
	draw_set_alpha(1);
	draw_set_color(-1);
	
	if(valor> .5)
	{
	
	draw_set_font(fnt_gover);
	draw_set_valign(1);
	draw_set_halign(1)
	draw_set_color(c_black);
	draw_text(meio_w+1,meio_h+1, "G a m e - O v e r");
	draw_text(meio_w+2,meio_h+2, "G a m e - O v e r");
	draw_text(meio_w+3,meio_h+3, "G a m e - O v e r");
	draw_set_color(c_white);
	draw_text(meio_w,meio_h, "G a m e - O v e r");
	draw_set_font(Font5);
	draw_text(meio_w, meio_h+50, "Pressione ENTER para recomeçar");
	draw_set_valign(-1);
	draw_set_halign(-1);
	draw_set_font(-1);
	draw_set_font(-1);
	draw_set_alpha(-1);
	
	}
}

else{
valor = 0;
}