package com.shopsphere.demo;

import java.text.NumberFormat;
import java.util.Locale;
import java.util.ResourceBundle;

public class InternationalizationDemo {

    public static void main(String[] args) {

        Locale englishLocale = Locale.of("en", "US");
        Locale hindiLocale = Locale.of("hi", "IN");

        ResourceBundle english =
                ResourceBundle.getBundle("messages", englishLocale);

        ResourceBundle hindi =
                ResourceBundle.getBundle("messages", hindiLocale);

        System.out.println("===== ENGLISH =====");
        System.out.println(english.getString("app.title"));
        System.out.println(english.getString("welcome.message"));
        System.out.println(english.getString("price.label"));

        System.out.println();

        System.out.println("===== HINDI =====");
        System.out.println(hindi.getString("app.title"));
        System.out.println(hindi.getString("welcome.message"));
        System.out.println(hindi.getString("price.label"));

        System.out.println();

        double price = 1499.99;

        NumberFormat englishCurrency =
                NumberFormat.getCurrencyInstance(englishLocale);

        NumberFormat indianCurrency =
                NumberFormat.getCurrencyInstance(hindiLocale);

        System.out.println("US Price: "
                + englishCurrency.format(price));

        System.out.println("Indian Price: "
                + indianCurrency.format(price));
    }
}