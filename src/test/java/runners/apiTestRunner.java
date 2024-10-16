package runners;

import com.intuit.karate.junit5.Karate;

public class apiTestRunner {

    @Karate.Test
    Karate testAll() {
        // Ejecuta todas las features en la carpeta 'features'
        return Karate.run("classpath:features").relativeTo(getClass());
    }
}
