package main;

import java.util.Scanner;

public class Main3 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] dice = new int[6];
        for (int i = 0; i < dice.length; i++) {
            dice[i] = sc.nextInt();
        }

        int min1 = Math.min(dice[0], dice[5]);
        int min2 = Math.min(dice[1], dice[4]);
        int min3 = Math.min(dice[2], dice[3]);

        long result = 0;
        if (n == 1) {
            // N�� 1�� ���� ��� ���� ���̹Ƿ� �ֻ����� �����ִ� ���� ���� ����
            result = dice[0] + dice[1] + dice[2] + dice[3] + dice[4] + dice[5];
        } else if (n == 2) {
            // N�� 2�� ���� 5���� �� �� ���̴� 3���� ���� ������ ���� �ּҰ��� ����
            result = (long) (4 * (min1 + min2 + min3) + 4 * (min1 + min2));
        } else {
            // N�� 3 �̻��� ���� 5���� �� �� ���̴� 4���� ���� ������ ���� �ּҰ��� ����
            result = (long) (4 * (min1 + min2 + min3) + 4 * (min1 + min2) + (n - 2) * (n - 2) * min1);
        }

        System.out.println(result);
    }
}