
package com.court.utility;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class Driver {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LegalDeskPU");

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

    public static void shutdown() {
        if (emf.isOpen()) {
            emf.close();
        }
    }
}
