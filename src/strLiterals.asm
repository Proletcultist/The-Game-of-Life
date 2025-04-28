rsect strLiterals

str_set1> dc "s1\0"
str_set0> dc "s0\0"
str_play> dc "play\0"
str_rules> dc "rules\0"
str_pause> dc "pause\0"
str_inv> dc "i\0"
str_step> dc "step\0"
str_su> dc "su\0"
str_sd> dc "sd\0"
str_ss> dc "ss\0"
str_clr> dc "clr\0"
str_srect1> dc "S1\0"
str_srect0> dc "S0\0"
str_savex> dc "saveX\0"
str_loadx> dc "loadX\0"
str_help> dc "h\0"

str_input> dc ">\0"
str_succ> dc "\r\n\033[32mSuccessful\033[0m\r\n\r\n\0"

error_large_coord> dc "\r\n\033[31mERROR\033[0m: Too large coordinate!\r\n\r\n\0"
error_inc_inp> dc "\r\n\033[31mERROR\033[0m: Incorrect input!\r\n\r\n\0"
error_few_args> dc "\r\n\033[31mERROR\033[0m: Too few arguments!\r\n\r\n\0"
error_no_args> dc "\r\n\033[31mERROR\033[0m: No arguments!\r\n\r\n\0"
error_inc_com> dc "\r\n\033[31mERROR\033[0m: Incorrect command!\r\n\r\n\0"
error_no_com> dc "\r\n\033[31mERROR\033[0m: No command!\r\n\r\n\0"
error_many_args> dc "\r\n\033[31mERROR\033[0m: Too many arguments!\r\n\r\n\0"
error_large_num> dc "\r\n\033[31mERROR\033[0m: Too large number!\r\n\r\n\0"
error_x_higher> dc "\r\n\033[31mERROR\033[0m: x1 higher than x2!\r\n\r\n\0"
error_y_higher> dc "\r\n\033[31mERROR\033[0m: y1 higher than y2!\r\n\r\n\0"
error_many_chars> dc "\r\n\033[31mERROR\033[0m: Too many characters!\r\n\r\n\0"

str_help_txt> dc "\r\nAvailable commands:\r\n\r\nh - Print this help message.\r\n\r\ns1 x y - Set the cell at coordinates (x, y) to alive.\r\n\r\ns0 x y - Set the cell at coordinates (x, y) to dead.\r\n\r\ni x y - Invert the status of the cell at coordinates (x, y).\r\n\r\nplay - Start the game.\r\n\r\npause - Pause the game.\r\n\r\nstep - Perform one iteration of the game.\r\n\r\nrules S<digits>B<digits> - Set custom rules for the game. Example: rules S23B3\r\n\r\nsu - Speed up the game.\r\n\r\nsd - Slow down the game.\r\n\r\nss n - Set game speed to value n.\r\n\r\nS1 x1 y1 x2 y2 - Set all cells in the rectangle from (x1, y1) to (x2, y2) to alive.\r\n\r\nS0 x1 y1 x2 y2 - Set all cells in the rectangle from (x1, y1) to (x2, y2) to dead.\r\n\r\nsaveX n x1 y1 x2 y2 - Save all cells in the rectangle from (x1, y1) to (x2, y2) into slot number n.\r\n\r\nloadX n x y - Load cells from slot n into the field with the upper-left corner at (x, y).\r\n\r\nclr - Clear the entire game field.\r\n\0"

end