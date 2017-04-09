/* 
 * This is an abstract class inherited by all objects, it includes general things so that you don't have to 
 * acces static stuff constantly.
 * 2017.04.09 - Kovacs Gyorgy
 */

abstract class Entity {
  public float scale = Const.scale; // Scale of the map (a scale of 1 -> (1 pixel = 1 cm))
} // End of Class