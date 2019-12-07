import java.util.Scanner;

public class questionA {
	// Global Variables
	public static Scanner in = new Scanner(System.in);
	public static String choice = null;
	public static int num;
	
	public static void main(String[] args) {
		// Create an array
		int[] array = {-100, -100, -100, -100, -100, -100, -100, -100, -100, -100};
		
		// Error catching
		do {
			try {
				System.out.println("-----------------------------------------------------");
				System.out.println("1. Populate the array with random numbers");
				System.out.println("2. Multiply the array with a user provided multiplier");
				System.out.println("3. Divide the array with a user provided divisor");
				System.out.println("4. Print the array");
				System.out.println("0. Exit");
				System.out.println("-----------------------------------------------------");
				
				// Collect input
				System.out.print("Enter a choice from the option: ");
				choice = in.next();
				
				// Switch statement 
				switch(choice) {
					case "1":
						System.out.println("Populating the array with then random numbers.");
						System.out.println();
						populateArray(array, -1500, 2500);
						break;
					case "2":
						System.out.print("Enter a number: ");
						num = in.nextInt();
						
						System.out.println();
						System.out.println("Multipling the elements in the array by a number given by the user.");
						multiplyArray(array, num);
						break;
					case "3":
						System.out.print("Enter a number: ");
						num = in.nextInt();
						
						System.out.println();
						System.out.println("Dividing the elements in the array by a number given by the user.");
						divideArray(array, num);
						break;
					case "4":
						System.out.println("Printing out the array...");
						System.out.println();
						printArray(array);
						break;
						
					case "0":
						throw new Exception();

					default:
						System.out.println("Invalid choice. Try again!");
						System.out.println();
						break;
				}
			}
			
			catch (Exception e) {
				System.out.println("Terminated program.");
				break;
			}
		}while(true);
	}
	
	/*
	 *
	 * Populates an array with random ints between -1500 +2500
	 * 
	 */
	public static int[] populateArray(int[] array, int low, int high) {
		for (int i = 0; i < array.length; i++) {
			int random = ((int) (Math.random() * (high - low + 1)) + low);
			array[i] = random;
		}
		return array;
	}

	/*
	 * 
	 * Multiplies all the elements in the array by a specific number 
	 * 
	 */
	public static int[] multiplyArray(int[] array, int num) {
		for (int i = 0; i < array.length; i++) {
			array[i] = array[i] * num;
		}
		return array;
	}
	
	/*
	 * 
	 * Divides all the elements in the array by a specific number
	 * 
	 */
	public static int[] divideArray(int[] array, int num) {
		for (int i = 0; i < array.length; i++) {
			array[i] = array[i] / num;
		}
		return array;
	}
	
	/*
	 * 
	 * Prints the array
	 * 
	 */
	public static void printArray(int[] array) {
		for (int element : array) System.out.print(element + ", ");
		System.out.println();
	}
}
