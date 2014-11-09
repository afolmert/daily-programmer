//

#include <string>
#include <iostream>
#include <memory>


#include <vector>
#include <unordered_map>


#include <cstdio>


namespace ck
{

/*
 * grid
 */

template <typename T>
class grid
{
public:
    grid(unsigned int width, unsigned int height);
    void fill(T value);
    void set_value(unsigned int x, unsigned int y, T value);
    T get_value(unsigned int x, unsigned int y) const;
    size_t size() const;
    unsigned int width() const;
    unsigned int height() const;
private:
    std::unique_ptr<T[]> _data;
    unsigned int _width;
    unsigned int _height;

    template <typename S>
    friend std::ostream &operator << (std::ostream &w, const grid<S> &expr);
};


template <typename T>
grid<T>::grid(unsigned int width, unsigned int height)
: _width(width), _height(height)
{
    _data = std::unique_ptr<T[]>(new T[width * height]);
}


template <typename T>
void grid<T>::set_value(unsigned int x, unsigned int y, T value)
{
    _data[_width * y + x] = value;
}

template <typename T>
T grid<T>::get_value(unsigned int x, unsigned int y) const
{
    return _data[_width * y + x];
}

template <typename T>
void grid<T>::fill(T value)
{
    for (unsigned int i = 0 ; i < _width * _height; i++) {
        _data[i] = value;
    }
}


template <typename T>
std::ostream &operator << (std::ostream &w, const grid<T> &grid)
{
    std::cout << "H: " << grid._height << "W: " << grid._width << std::endl;

    for (unsigned int y = 0; y < grid._height; y++) {
        for (unsigned int x = 0; x < grid._width; x++) {
            std::cout << grid.get_value(x, y);
        }
        std::cout << std::endl;
    }
    return w;
}


template <typename T>
size_t grid<T>::size() const
{
    return _width * _height;
}


template <typename T>
unsigned int grid<T>::width() const
{
    return _width;
}

template <typename T>
unsigned int grid<T>::height() const
{
    return _height;
}



/*
 * game
 */

class game
{
public:
    game();
    void initialize();
    void next_stage();
    void test_grid();
private:
    grid<char> _grid;

};

game::game()
: _grid(20, 20)

{
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            _grid.set_value(i, j, 1);
        }
    }
}

void game::initialize()
{
}


void game::next_stage()
{
    grid<char> new_grid(20, 20);

    for (int x = 0; x < new_grid.width(); x++) {
        for (int y = 0; y  < new_grid.height(); y++) {
        }
    }
}


void game::test_grid()
{
    grid<std::string> string_grid(20, 20);
    string_grid.fill("x");


    std::cout << string_grid;

    for (int i = 0; i < string_grid.width(); i++) {
        for (int j = 0; j < string_grid.height(); j++) {

            string_grid.set_value(i, j, "x");
        }
    }
}





/*
 * codekata
 */

class codekata
{
public:
    void run(const std::string &s);
};


void codekata::run(const std::string &s)
{
    grid<int> gr(10, 10);
    gr.fill(0);

    gr.set_value(2, 2, 5);
    gr.set_value(3, 3, 4);


    grid<std::string> grid2(44, 5);
    grid2.fill("A");

    for (int x = 0; x < grid2.width(); x++) {
        for (int y = 0; y < grid2.height(); y++) {
            grid2.set_value(x, y, ".");
        }
    }


    grid2.set_value(1, 1, "O");
    grid2.set_value(2, 2, "I");
    grid2.set_value(3, 2, "E");
    grid2.set_value(4, 4, "X");


    std::cout << grid2;

}


}



int main(int argc, const char *argv[])
{

    ck::codekata ck;
    ck.run("Hello world!");

    std::cout << "Press any key to continue ... " << std::endl;


    return 0;
}

