#include <stdio.h>
#include <time.h>

int main(int argc, char *argv[]) {
    time_t now;
    struct tm *timeinfo;
    
    time(&now);
    timeinfo = localtime(&now);
    
    printf("╔════════════════════════════════════════╗\n");
    printf("║     Welcome to ZynqOS!                 ║\n");
    printf("║     Hello from ZynqOS User Repository  ║\n");
    printf("╚════════════════════════════════════════╝\n\n");
    
    printf("Current time: %s", asctime(timeinfo));
    printf("\nThis is an example package from ZUR (ZynqOS User Repository)\n");
    printf("Similar to AUR (Arch User Repository)\n\n");
    
    if (argc > 1) {
        printf("Hello, %s!\n", argv[1]);
    }
    
    return 0;
}
