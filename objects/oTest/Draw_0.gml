if (not surface_exists(surface))
{
    surface = surface_create(room_width, room_height);
    buffer_set_surface(correlationBuffer, surface, 0);
}

draw_surface(surface, 0, 0);