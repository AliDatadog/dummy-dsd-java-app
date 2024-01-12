import com.timgroup.statsd.NonBlockingStatsDClientBuilder;
import com.timgroup.statsd.NonBlockingStatsDClient;
import com.timgroup.statsd.StatsDClient;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        String metricName = "dummy.metric";
        StatsDClient client = new NonBlockingStatsDClientBuilder().build();
        Random random = new Random();
        while (true) {
            double value = random.nextDouble();
            client.gauge(metricName, value);

            System.out.println("Sent metric: " + metricName + " with value: " + value);

            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
                break;
            }
        }

        client.stop();
    }
}
