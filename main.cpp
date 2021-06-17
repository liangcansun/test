#include <iostream>
#include <thread>
#include<chrono>

using namespace std;
void test(){
    std::cout<<"ceshi"<<std::endl;
    this_thread::sleep_for(chrono::milliseconds(10));
}
int main() {
    std::cout << "Hello, World!" << std::endl;
    thread t1(test);
    t1.join();

    return 0;
}
