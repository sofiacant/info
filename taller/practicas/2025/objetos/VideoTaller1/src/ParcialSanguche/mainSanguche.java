/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ParcialSanguche;

/**
 *
 * @author Sofia C
 */
public class mainSanguche {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Pan pan1 = new Pan("Brioche", 100, "Premium");
        Sanguche s = new Sanguche("Sanguchan", pan1, 4);

        Ingrediente ing1 = new Ingrediente("Tomate", 123, "A");

        Ingrediente ing2 = new Ingrediente("Lechuga", 634, "B");

        Ingrediente ing3 = new Ingrediente("Queso", 624, "A");

        Ingrediente ing4 = new Ingrediente("Jamon", 129, "B");

        s.agregarIngrediente(ing4);
        s.agregarIngrediente(ing3);
        s.agregarIngrediente(ing2);
        s.agregarIngrediente(ing1);

        System.out.println(s.toString());

    }
}
