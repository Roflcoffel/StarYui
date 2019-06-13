#include "main.hpp"

std::vector<int> Range(int, int, int);
std::vector<std::string> Tree(int);

int main() {
    sf::RenderWindow window(sf::VideoMode(200, 200), "SFML works!");
    sf::CircleShape shape(100.f);
    shape.setFillColor(sf::Color::Green);

    sf::Event event;
    sf::Clock clock;
    sf::Color color(sf::Color::Red);

    srand(time(NULL));

    while (window.isOpen())
    {
        while (window.pollEvent(event))
        {
            if (event.type == sf::Event::Closed)
                window.close();

            if (event.type == sf::Event::EventType::KeyPressed)
            {
                if(event.key.code == sf::Keyboard::Space) {
                    color.r = 0;
                    color.b = 0;
                    color.g = 0;
                }

                if(event.key.code == sf::Keyboard::R)
                    color.r = rand() % 255;
                if(event.key.code == sf::Keyboard::B)
                    color.b = rand() % 255;
                if(event.key.code == sf::Keyboard::G)
                    color.g = rand() % 255;
            }
        }

        //Will be used to calculate FPS and Delta time
        //std::cout << "Elapsed time microseconds: " << clock.getElapsedTime().asMicroseconds() << std::endl;
        //clock.restart();

        window.clear(color);
        window.draw(shape);
        window.display();
    }

    std::vector<std::string> tree = Tree(6);

    for(auto y: tree) std::cout << y << "\n";


    return 0;
}

std::vector<int> Range(int start, int max, int step) {
    std::vector<int> raVector;

    for(int i = start; i <= max; i+=step)
    {
        raVector.push_back(i);
    }

    return raVector;
}


std::vector<std::string> Tree(int height) {
    std::vector<std::string> tree;

    int spaces = height - 1;
    int stump = height - 1;
    int leaves = 1;

    while(height != 0) {
        std::string row;

        for(int i = 0; i < spaces; i++) row += " ";
        for(int i = 0; i < leaves; i++) row += "#";

        leaves += 2;
        spaces -= 1;

        height -= 1;

        tree.push_back(row);
    }

    //stump of tree
    std::string row;
    for(int i = 0; i < stump; i++) row += " ";
    row += "#";

    tree.push_back(row);

    return tree;
}