package services;

import dtosUI.MemberUI;

import java.time.LocalDate;
import java.util.Date;

public class MemberServices {
    public String insertNewMember(MemberUI newMember) {
        String message ="";
        //comprobaciones antes de llamar al MemberRepository
        //join date tiene que ser fecha anterior a hoy
        Date ahora = new Date(); // Crea una fecha con el instante actual del sistema
        if (newMember.getJoinDate().after(ahora)){

        }
        //position name tiene que existir y tener un id recuperable

        //cateory tiene que existir y ser recuperable
        return message;
    }
}
